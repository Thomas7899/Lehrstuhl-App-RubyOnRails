(() => {
  // app/javascript/chatbot.js
  document.addEventListener("turbo:load", function() {
    console.log("Chatbot initializing on turbo:load...");
    function initChatbot() {
      const chatForm = document.getElementById("chatForm");
      if (!chatForm) {
        console.log("Chatbot elements not found - not on chatbot page.");
        return;
      }
      console.log("Chatbot elements found, initializing event listeners...");
      const messageInput = document.getElementById("messageInput");
      const sendBtn = document.getElementById("sendBtn");
      const chatMessages = document.getElementById("chatMessages");
      const typingIndicator = document.getElementById("typingIndicator");
      const clearChatBtn = document.getElementById("clearChatBtn");
      const quickQuestions = document.querySelectorAll(".quick-question");
      const scrollToBottom = () => {
        if (chatMessages) chatMessages.scrollTop = chatMessages.scrollHeight;
      };
      const formatMessageContent = (content) => {
        return content.replace(/\n/g, "<br>").replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>").replace(/\*(.*?)\*/g, "<em>$1</em>").replace(/`(.*?)`/g, "<code>$1</code>");
      };
      const addMessage = (content, role, timestamp = null) => {
        const messageDiv = document.createElement("div");
        messageDiv.className = role === "user" ? "user-message message-appear" : "assistant-message message-appear";
        const time = timestamp || (/* @__PURE__ */ new Date()).toLocaleTimeString("de-DE", { hour: "2-digit", minute: "2-digit" });
        messageDiv.innerHTML = `
        <div class="message-avatar"><i class="bi bi-${role === "user" ? "person-circle" : "robot"}"></i></div>
        <div class="message-content">
          <div class="message-bubble ${role}">${formatMessageContent(content)}</div>
          <div class="message-time">${time}</div>
        </div>`;
        chatMessages.appendChild(messageDiv);
        scrollToBottom();
      };
      const showTyping = () => {
        if (typingIndicator) typingIndicator.style.display = "block";
        scrollToBottom();
      };
      const hideTyping = () => {
        if (typingIndicator) typingIndicator.style.display = "none";
      };
      const toggleSendButton = (disabled) => {
        if (!sendBtn) return;
        sendBtn.disabled = disabled;
        const icon = sendBtn.querySelector("i");
        if (icon) icon.className = disabled ? "bi bi-hourglass-split" : "bi bi-send-fill";
        sendBtn.classList.toggle("disabled", disabled);
      };
      const getCSRFToken = () => document.querySelector('meta[name="csrf-token"]')?.content;
      const showErrorToast = (message) => {
        console.error("Toast Error:", message);
        alert("Fehler: " + message);
      };
      const sendMessage = async (message) => {
        if (!message || !message.trim()) return;
        addMessage(message, "user");
        if (messageInput) messageInput.value = "";
        toggleSendButton(true);
        showTyping();
        const csrfToken = getCSRFToken();
        if (!csrfToken) {
          hideTyping();
          toggleSendButton(false);
          showErrorToast("CSRF Token fehlt - Seite neu laden");
          return;
        }
        try {
          const response = await fetch("/chatbot", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "X-CSRF-Token": csrfToken
            },
            body: JSON.stringify({ message: message.trim() })
          });
          hideTyping();
          const data = await response.json();
          if (!response.ok) {
            throw new Error(data.error || `HTTP ${response.status}`);
          }
          if (data.bot_message) {
            addMessage(data.bot_message.content, "assistant", data.bot_message.timestamp);
          } else {
            throw new Error("Unerwartetes Antwortformat vom Server.");
          }
        } catch (error) {
          hideTyping();
          console.error("Chat Error:", error);
          addMessage(`Entschuldigung, ein Fehler ist aufgetreten. (${error.message})`, "assistant");
        } finally {
          toggleSendButton(false);
          if (messageInput) messageInput.focus();
        }
      };
      if (chatForm.dataset.initialized === "true") {
        console.log("Chatbot already initialized. Skipping.");
        return;
      }
      chatForm.dataset.initialized = "true";
      chatForm.addEventListener("submit", (e) => {
        e.preventDefault();
        sendMessage(messageInput.value);
      });
      if (messageInput) {
        messageInput.addEventListener("keydown", (e) => {
          if (e.key === "Enter" && !e.shiftKey) {
            e.preventDefault();
            sendMessage(messageInput.value);
          }
        });
      }
      if (clearChatBtn) {
        clearChatBtn.addEventListener("click", async () => {
          if (!confirm("M\xF6chten Sie wirklich den gesamten Chat-Verlauf l\xF6schen?")) return;
          try {
            const response = await fetch("/chatbot/clear_history", {
              method: "DELETE",
              headers: { "X-CSRF-Token": getCSRFToken() }
            });
            if (response.ok) {
              chatMessages.querySelectorAll(".user-message, .assistant-message").forEach((msg) => msg.remove());
              addMessage("Chat-Verlauf wurde gel\xF6scht.", "assistant");
            } else {
              throw new Error("L\xF6schen fehlgeschlagen.");
            }
          } catch (error) {
            showErrorToast(error.message);
          }
        });
      }
      quickQuestions.forEach((btn) => {
        btn.addEventListener("click", (e) => {
          const question = e.currentTarget.dataset.question;
          if (question) {
            messageInput.value = question;
            sendMessage(question);
          }
        });
      });
      if (messageInput) messageInput.focus();
      setTimeout(scrollToBottom, 100);
      console.log("Chatbot event listeners attached successfully!");
    }
    initChatbot();
  });
})();
