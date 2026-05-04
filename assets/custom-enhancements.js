// custom-enhancements.js

document.addEventListener('DOMContentLoaded', () => {
    // 1. Setup Intersection Observer for Scroll Animations
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.15 // Trigger when 15% of element is visible
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('is-visible');
                // Optional: stop observing once animated
                // observer.unobserve(entry.target); 
            }
        });
    }, observerOptions);

    // 2. Select elements to animate
    // We target main headings, text blocks, and icon boxes from Elementor
    const elementsToAnimate = document.querySelectorAll('.elementor-heading-title, .elementor-text-editor, .elementor-icon-box-wrapper, .elementor-button, .elementor-image');
    
    elementsToAnimate.forEach(el => {
        // Only add animation class if it's not in the header (don't want the header animating in late)
        if (!el.closest('.elementor-location-header')) {
            el.classList.add('animate-on-scroll');
            observer.observe(el);
        }
    });

    // 3. Ensure mega-menus work on mobile if elementor JS didn't initialize fully
    const mobileToggles = document.querySelectorAll('.elementor-menu-toggle');
    mobileToggles.forEach(toggle => {
        toggle.addEventListener('click', function() {
            this.classList.toggle('elementor-active');
            const nav = this.nextElementSibling;
            if (nav && nav.classList.contains('elementor-nav-menu__container')) {
                if (nav.style.maxHeight) {
                    nav.style.maxHeight = null;
                } else {
                    nav.style.maxHeight = nav.scrollHeight + "px";
                }
            }
        });
    });
});
