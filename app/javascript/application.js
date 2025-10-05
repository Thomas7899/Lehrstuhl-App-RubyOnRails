import "@hotwired/turbo-rails"
import "./controllers"
import "./chatbot"

// Bootstrap Dropdowns initialisieren
document.addEventListener('DOMContentLoaded', initializeBootstrapDropdowns);
document.addEventListener('turbo:load', initializeBootstrapDropdowns);
document.addEventListener('turbo:after-render', () => setTimeout(initializeBootstrapDropdowns, 50));

function initializeBootstrapDropdowns() {
    setTimeout(() => {
        if (typeof bootstrap !== 'undefined') {
            const dropdownButtons = document.querySelectorAll('[data-bs-toggle="dropdown"]');
            
            dropdownButtons.forEach((button) => {
                try {
                    const existingInstance = bootstrap.Dropdown.getInstance(button);
                    if (existingInstance) {
                        existingInstance.dispose();
                    }
                    new bootstrap.Dropdown(button);
                } catch (error) {
                    console.error('Fehler bei Dropdown-Initialisierung:', error);
                }
            });
        }
    }, 200);
}

// Header Navigation
document.addEventListener('turbo:load', function() {
  const navbar = document.querySelector('.modern-navbar');
  if (navbar) {
    window.addEventListener('scroll', function() {
      if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
      } else {
        navbar.classList.remove('scrolled');
      }
    });
  }
  
  const searchInput = document.querySelector('.modern-search-input');
  if (searchInput) {
    searchInput.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        this.closest('form').submit();
      }
    });
  }
});

// Studierenden Filter-System
document.addEventListener('turbo:load', function() {
  
  function initStudentFilters() {
    const searchInput = document.getElementById('searchInput');
    const sortSelect = document.getElementById('sortSelect');
    const birthYearFilter = document.getElementById('birthYearFilter');
    const perPageSelect = document.getElementById('perPageSelect');
    const resetFiltersBtn = document.getElementById('resetFilters');
    const gridView = document.getElementById('gridView');
    const listView = document.getElementById('listView');
    const studentsGrid = document.getElementById('studentsGrid');
    const studentsList = document.getElementById('studentsList');
    const totalCount = document.getElementById('totalCount');
    const filterInfo = document.getElementById('filterInfo');
    
    if (!searchInput) return;
    
    let allStudents = [];
    let filteredStudents = [];
    let currentView = 'grid';
    
    function collectStudentData() {
      const studentItems = document.querySelectorAll('.student-item');
      const studentRows = document.querySelectorAll('.student-row');
      
      allStudents = [];
      
      studentItems.forEach((item, index) => {
        const row = studentRows[index];
        allStudents.push({
          gridElement: item,
          listElement: row,
          name: item.dataset.name.toLowerCase(),
          email: item.dataset.email.toLowerCase(),
          matrikelnummer: item.dataset.matrikelnummer,
          geburtsjahr: item.dataset.geburtsjahr,
          searchText: `${item.dataset.name} ${item.dataset.email} ${item.dataset.matrikelnummer}`.toLowerCase()
        });
      });
      
      filteredStudents = [...allStudents];
    }
    
    function applyFilters() {
      const searchTerm = searchInput.value.toLowerCase().trim();
      const selectedYear = birthYearFilter.value;
      
      filteredStudents = allStudents.filter(student => {
        const matchesSearch = !searchTerm || student.searchText.includes(searchTerm);
        const matchesYear = !selectedYear || student.geburtsjahr === selectedYear;
        return matchesSearch && matchesYear;
      });
      
      applySorting();
      displayResults();
      updateStats();
    }
    
    function applySorting() {
      const sortValue = sortSelect.value;
      
      filteredStudents.sort((a, b) => {
        switch (sortValue) {
          case 'nachname':
            return a.name.split(' ')[1].localeCompare(b.name.split(' ')[1]);
          case 'nachname_desc':
            return b.name.split(' ')[1].localeCompare(a.name.split(' ')[1]);
          case 'vorname':
            return a.name.split(' ')[0].localeCompare(b.name.split(' ')[0]);
          case 'vorname_desc':
            return b.name.split(' ')[0].localeCompare(a.name.split(' ')[0]);
          case 'email':
            return a.email.localeCompare(b.email);
          case 'matrikelnummer':
            return a.matrikelnummer.localeCompare(b.matrikelnummer);
          case 'geburtsjahr':
            return (a.geburtsjahr || '0').localeCompare(b.geburtsjahr || '0');
          case 'geburtsjahr_desc':
            return (b.geburtsjahr || '0').localeCompare(a.geburtsjahr || '0');
          default:
            return 0;
        }
      });
    }
    
    function displayResults() {
      allStudents.forEach(student => {
        student.gridElement.style.display = 'none';
        student.listElement.style.display = 'none';
      });
      
      filteredStudents.forEach(student => {
        if (currentView === 'grid') {
          student.gridElement.style.display = 'block';
        } else {
          student.listElement.style.display = 'table-row';
        }
      });
    }
    
    function updateStats() {
      totalCount.textContent = filteredStudents.length;
      
      if (filteredStudents.length !== allStudents.length) {
        filterInfo.textContent = ` (von ${allStudents.length} gefiltert)`;
      } else {
        filterInfo.textContent = '';
      }
    }
    
    function switchView(view) {
      currentView = view;
      
      if (view === 'grid') {
        studentsGrid.style.display = 'block';
        studentsList.style.display = 'none';
        gridView.classList.add('active');
        listView.classList.remove('active');
      } else {
        studentsGrid.style.display = 'none';
        studentsList.style.display = 'block';
        listView.classList.add('active');
        gridView.classList.remove('active');
      }
      
      displayResults();
    }
    
    function resetFilters() {
      searchInput.value = '';
      sortSelect.value = 'nachname';
      birthYearFilter.value = '';
      perPageSelect.value = '24';
      
      filteredStudents = [...allStudents];
      applySorting();
      displayResults();
      updateStats();
    }
    
    function debounce(func, wait) {
      let timeout;
      return function executedFunction(...args) {
        const later = () => {
          clearTimeout(timeout);
          func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
      };
    }
    
    searchInput.addEventListener('input', debounce(applyFilters, 300));
    sortSelect.addEventListener('change', applyFilters);
    birthYearFilter.addEventListener('change', applyFilters);
    resetFiltersBtn.addEventListener('click', resetFilters);
    gridView.addEventListener('click', () => switchView('grid'));
    listView.addEventListener('click', () => switchView('list'));
    
    perPageSelect.addEventListener('change', function() {
      const currentUrl = new URL(window.location);
      currentUrl.searchParams.set('per_page', this.value);
      currentUrl.searchParams.delete('page');
      window.location.href = currentUrl.toString();
    });
    
    collectStudentData();
    updateStats();
  }

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

  initStudentFilters();
  initCardEffects();
});