/* ==========================================================================
   CRAVIO HERO SLIDER & CAROUSEL ENGINE
   Smooth automatic rotation for hero banner photography and testimonials
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {
  // Hero Slider logic
  const slides = document.querySelectorAll('.hero-slide');
  if (slides.length > 0) {
    let currentSlide = 0;
    const slideInterval = 4500; // 4.5 seconds per slide

    function nextSlide() {
      slides[currentSlide].classList.remove('active');
      currentSlide = (currentSlide + 1) % slides.length;
      slides[currentSlide].classList.add('active');
    }

    setInterval(nextSlide, slideInterval);
  }

  // Testimonials Carousel Logic
  const testimonials = document.querySelectorAll('.testimonial-card');
  if (testimonials.length > 0) {
    let currentTestimonial = 0;
    setInterval(() => {
      testimonials.forEach(t => t.style.display = 'none');
      currentTestimonial = (currentTestimonial + 1) % testimonials.length;
      testimonials[currentTestimonial].style.display = 'block';
      testimonials[currentTestimonial].classList.add('fade-in-up');
    }, 5000);
  }
});
