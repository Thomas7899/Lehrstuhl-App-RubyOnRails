// Moderne Studierenden-Interaktivität

document.addEventListener('DOMContentLoaded', function() {
  
  // Smooth scrolling für bessere UX
  function addSmoothScrolling() {
    const links = document.querySelectorAll('a[href^="#"]');
    links.forEach(link => {
      link.addEventListener('click', function(e) {
        const targetId = this.getAttribute('href');
        if (targetId === '#') return;
        
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
          e.preventDefault();
          targetElement.scrollIntoView({
            behavior: 'smooth'
          });
        }
      });
    });
  }

  // Carousel Auto-pause on hover
  function initCarouselControls() {
    const carousel = document.querySelector('#studentsCarousel');
    if (carousel) {
      const bsCarousel = new bootstrap.Carousel(carousel, {
        interval: false,
        wrap: true
      });
      
      // Pause auf Hover
      carousel.addEventListener('mouseenter', function() {
        bsCarousel.pause();
      });
      
      // Resume on mouse leave
      carousel.addEventListener('mouseleave', function() {
        // Bleibt pausiert für bessere Benutzererfahrung
      });
      
      // Keyboard navigation
      document.addEventListener('keydown', function(e) {
        if (e.key === 'ArrowLeft') {
          bsCarousel.prev();
        } else if (e.key === 'ArrowRight') {
          bsCarousel.next();
        }
      });
    }
  }

  // Card hover effects
  function initCardEffects() {
    const cards = document.querySelectorAll('.modern-student-card, .modern-student-card-grid');
    
    cards.forEach(card => {
      card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-8px)';
      });
      
      card.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0)';
      });
    });
  }

  // Animate elements on scroll
  function initScrollAnimations() {
    const observerOptions = {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('animate-in');
        }
      });
    }, observerOptions);

    // Observe cards
    const cards = document.querySelectorAll('.modern-student-card-grid');
    cards.forEach((card, index) => {
      card.style.opacity = '0';
      card.style.transform = 'translateY(20px)';
      card.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
      observer.observe(card);
    });
  }

  // Toast notifications für bessere UX
  function initToastNotifications() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
      if (alert.classList.contains('alert-success')) {
        // Auto-hide success alerts after 5 seconds
        setTimeout(() => {
          const bsAlert = new bootstrap.Alert(alert);
          bsAlert.close();
        }, 5000);
      }
    });
  }

  // Touch/swipe support für mobile Geräte
  function initTouchSupport() {
    const carousel = document.querySelector('#studentsCarousel');
    if (!carousel) return;

    let startX = 0;
    let endX = 0;

    carousel.addEventListener('touchstart', function(e) {
      startX = e.changedTouches[0].screenX;
    });

    carousel.addEventListener('touchend', function(e) {
      endX = e.changedTouches[0].screenX;
      handleSwipe();
    });

    function handleSwipe() {
      const swipeThreshold = 50;
      const diff = startX - endX;

      if (Math.abs(diff) > swipeThreshold) {
        const bsCarousel = bootstrap.Carousel.getInstance(carousel);
        if (diff > 0) {
          // Swipe left - next slide
          bsCarousel.next();
        } else {
          // Swipe right - previous slide
          bsCarousel.prev();
        }
      }
    }
  }

  // Search functionality enhancement
  function initSearchEnhancements() {
    const searchInput = document.querySelector('#search_input');
    if (searchInput) {
      // Add search icon
      const searchContainer = searchInput.parentElement;
      searchContainer.style.position = 'relative';
      
      const searchIcon = document.createElement('i');
      searchIcon.className = 'bi bi-search';
      searchIcon.style.position = 'absolute';
      searchIcon.style.right = '12px';
      searchIcon.style.top = '50%';
      searchIcon.style.transform = 'translateY(-50%)';
      searchIcon.style.color = '#6b7280';
      searchIcon.style.pointerEvents = 'none';
      
      searchContainer.appendChild(searchIcon);
      searchInput.style.paddingRight = '40px';
    }
  }

  // Initialize all features
  addSmoothScrolling();
  initCarouselControls();
  initCardEffects();
  initScrollAnimations();
  initToastNotifications();
  initTouchSupport();
  initSearchEnhancements();

});

// CSS für Scroll-Animationen
const style = document.createElement('style');
style.textContent = `
  .animate-in {
    opacity: 1 !important;
    transform: translateY(0) !important;
  }
  
  .modern-student-card-grid:hover {
    transform: translateY(-8px) !important;
  }
  
  .modern-btn:active {
    transform: translateY(0) !important;
  }
  
  @media (prefers-reduced-motion: reduce) {
    * {
      animation-duration: 0.01ms !important;
      animation-iteration-count: 1 !important;
      transition-duration: 0.01ms !important;
    }
  }
`;
document.head.appendChild(style);
