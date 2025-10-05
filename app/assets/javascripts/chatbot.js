// Chatbot Functionality
document.addEventListener('DOMContentLoaded', function() {
  
  function initChatbot() {
    const chatForm = document.getElementById('chatForm');
    const messageInput = document.getElementById('messageInput');
    const sendBtn = document.getElementById('sendBtn');
    const chatMessages = document.getElementById('chatMessages');
    const typingIndicator = document.getElementById('typingIndicator');
    const clearChatBtn = document.getElementById('clearChatBtn');
    const quickQuestions = document.querySelectorAll('.quick-question');
    
    if (!chatForm) return; // Nicht auf der Chatbot-Seite
    
    // Auto-scroll zum Ende
    function scrollToBottom() {
      chatMessages.scrollTop = chatMessages.scrollHeight;
    }
    
    // Nachricht zum Chat hinzufügen
    function addMessage(content, role, timestamp = null) {
      const messageDiv = document.createElement('div');
      messageDiv.className = role === 'user' ? 'user-message message-appear' : 'assistant-message message-appear';
      
      const time = timestamp || new Date().toLocaleTimeString('de-DE', { 
        hour: '2-digit', 
        minute: '2-digit' 
      });
      
      messageDiv.innerHTML = `
        <div class="message-avatar">
          <i class="bi bi-${role === 'user' ? 'person-circle' : 'robot'}"></i>
        </div>
        <div class="message-content">
          <div class="message-bubble ${role}">
            ${formatMessageContent(content)}
          </div>
          <div class="message-time">
            ${time}
          </div>
        </div>
      `;
      
      chatMessages.appendChild(messageDiv);
      scrollToBottom();
    }
    
    // Nachrichteninhalt formatieren
    function formatMessageContent(content) {
      return content
        .replace(/\n/g, '<br>')
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\*(.*?)\*/g, '<em>$1</em>')
        .replace(/`(.*?)`/g, '<code>$1</code>');
    }
    
    // Typing Indicator anzeigen
    function showTyping() {
      typingIndicator.style.display = 'block';
      scrollToBottom();
    }
    
    // Typing Indicator verstecken
    function hideTyping() {
      typingIndicator.style.display = 'none';
    }
    
    // Button-Status umschalten
    function toggleSendButton(disabled) {
      sendBtn.disabled = disabled;
      const icon = sendBtn.querySelector('i');
      
      if (disabled) {
        icon.className = 'bi bi-hourglass-split';
        sendBtn.classList.add('disabled');
      } else {
        icon.className = 'bi bi-send-fill';
        sendBtn.classList.remove('disabled');
      }
    }
    
    // Nachricht senden
    async function sendMessage(message) {
      if (!message.trim()) return;
      
      // UI Updates
      addMessage(message, 'user');
      messageInput.value = '';
      toggleSendButton(true);
      showTyping();
      
      try {
        const response = await fetch('/chatbot', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          },
          body: JSON.stringify({ message: message })
        });
        
        const data = await response.json();
        
        hideTyping();
        
        if (response.ok && data.bot_message) {
          addMessage(data.bot_message.content, 'assistant', data.bot_message.timestamp);
        } else {
          throw new Error(data.error || 'Unbekannter Fehler');
        }
        
      } catch (error) {
        hideTyping();
        console.error('Chat Error:', error);
        
        addMessage(
          'Entschuldigung, ich kann Ihre Anfrage gerade nicht bearbeiten. Bitte versuchen Sie es später erneut.',
          'assistant'
        );
        
        showErrorToast(error.message || 'Verbindungsfehler');
      } finally {
        toggleSendButton(false);
        messageInput.focus();
      }
    }
    
    // Error Toast anzeigen
    function showErrorToast(message) {
      const errorToast = document.getElementById('errorToast');
      const errorMessage = document.getElementById('errorMessage');
      
      errorMessage.textContent = message;
      
      const toast = new bootstrap.Toast(errorToast);
      toast.show();
    }
    
    // Chat-Verlauf löschen
    async function clearChatHistory() {
      if (!confirm('Möchten Sie wirklich den gesamten Chat-Verlauf löschen?')) return;
      
      try {
        const response = await fetch('/chatbot/clear_history', {
          method: 'DELETE',
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          }
        });
        
        if (response.ok) {
          // Alle Nachrichten außer Welcome Message entfernen
          const messages = chatMessages.querySelectorAll('.user-message, .assistant-message:not(.welcome-message .assistant-message)');
          messages.forEach(msg => msg.remove());
        }
        
      } catch (error) {
        showErrorToast('Fehler beim Löschen des Chat-Verlaufs');
      }
    }
    
    // Event Listeners
    chatForm.addEventListener('submit', function(e) {
      e.preventDefault();
      const message = messageInput.value.trim();
      if (message) {
        sendMessage(message);
      }
    });
    
    // Enter-Taste für Senden (Shift+Enter für neue Zeile)
    messageInput.addEventListener('keydown', function(e) {
      if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        chatForm.dispatchEvent(new Event('submit'));
      }
    });
    
    // Schnelle Fragen
    quickQuestions.forEach(btn => {
      btn.addEventListener('click', function() {
        const question = this.dataset.question;
        messageInput.value = question;
        sendMessage(question);
      });
    });
    
    // Chat löschen
    clearChatBtn.addEventListener('click', clearChatHistory);
    
    // Auto-focus auf Input
    messageInput.focus();
    
    // Initial scroll to bottom
    setTimeout(scrollToBottom, 100);
  }
  
  // Initialize
  initChatbot();
});
