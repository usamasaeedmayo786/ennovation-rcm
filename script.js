// E-nnovationrcm - SPA Router & Logic

// Data for dynamic page generation
const pages = {
    'home': `
        <section class="hero">
            <div class="container">
                <div class="hero-content">
                    <div class="ai-badge">
                        <i class="fas fa-bolt"></i> AI POWERED
                    </div>
                    <h1 class="hero-title">
                        AI-Powered
                        <span>Medical Billing Services</span>
                    </h1>
                    <p class="hero-desc">Maximize revenue and eliminate administrative burdens with our intelligent, 100% HIPAA compliant medical billing solutions for practices across the USA and Canada.</p>
                    
                    <div class="hero-benefits">
                        <div class="benefit-item">
                            <i class="fas fa-check-circle"></i> 75+ Specialties
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-check-circle"></i> USA/Canada Support
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-check-circle"></i> 99% Clean Claim Rate
                        </div>
                    </div>
                    
                    <div class="hero-actions">
                        <a href="#consultation" class="btn btn-primary">Free Consultation</a>
                        <a href="#about" class="btn btn-outline">Learn More</a>
                    </div>
                </div>
                <div class="hero-image">
                    <div class="hero-img-wrapper">
                        <!-- We use the generated asset or a placeholder if missing -->
                        <img src="assets/hero_bg.png" alt="Medical Professional" onerror="this.src='https://images.unsplash.com/photo-1551076805-e1869043e560?auto=format&fit=crop&w=800&q=80'">
                    </div>
                </div>
            </div>
        </section>

        <section class="services-overview section-padding">
            <div class="container">
                <div class="section-heading">
                    <span class="section-tag">Our Solutions</span>
                    <h2 class="section-title">Comprehensive Revenue Cycle Management</h2>
                    <p>End-to-end RCM solutions designed to reduce your AR days, improve cash flow, and ensure you get paid for every service rendered.</p>
                </div>

                <div class="services-grid">
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-file-invoice-dollar"></i></div>
                        <h3>Claim Submission</h3>
                        <p>AI-driven claim scrubbing ensures maximum accuracy before submission, drastically reducing denial rates.</p>
                        <a href="#claim-submission" class="learn-more">Learn more <i class="fas fa-arrow-right"></i></a>
                    </div>
                    
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-undo"></i></div>
                        <h3>AR Recovery</h3>
                        <p>Aggressive follow-ups and strategic recovery plans to reduce your accounts receivable significantly.</p>
                        <a href="#ar-recovery" class="learn-more">Learn more <i class="fas fa-arrow-right"></i></a>
                    </div>
                    
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-user-check"></i></div>
                        <h3>Eligibility Verification</h3>
                        <p>Real-time patient eligibility checks to prevent rejections and ensure accurate patient billing.</p>
                        <a href="#eligibility" class="learn-more">Learn more <i class="fas fa-arrow-right"></i></a>
                    </div>
                    
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-shield-alt"></i></div>
                        <h3>Denial Management</h3>
                        <p>Identify root causes of denials, correct claims, and resubmit rapidly to boost reimbursements.</p>
                        <a href="#denial-management" class="learn-more">Learn more <i class="fas fa-arrow-right"></i></a>
                    </div>
                    
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-laptop-medical"></i></div>
                        <h3>Medical Coding</h3>
                        <p>AAPC-certified coders specialized in various medical fields ensuring compliant and optimized coding.</p>
                        <a href="#coding" class="learn-more">Learn more <i class="fas fa-arrow-right"></i></a>
                    </div>
                    
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-clipboard-check"></i></div>
                        <h3>Prior Authorization</h3>
                        <p>Streamlined processes to stop treatment delays and ensure services are authorized promptly.</p>
                        <a href="#prior-auth" class="learn-more">Learn more <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Stats Section -->
        <section class="stats-section">
            <div class="container">
                <div class="stats-grid">
                    <div class="stat-item">
                        <h2>15+</h2>
                        <p>Years Experience</p>
                    </div>
                    <div class="stat-item">
                        <h2>500+</h2>
                        <p>Providers Served</p>
                    </div>
                    <div class="stat-item">
                        <h2>75+</h2>
                        <p>Specialties</p>
                    </div>
                    <div class="stat-item">
                        <h2>100%</h2>
                        <p>AAPC Certified</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Why Choose Us -->
        <section class="features-section section-padding">
            <div class="container">
                <div class="features-layout">
                    <div class="features-content">
                        <span class="section-tag">Why E-nnovationrcm</span>
                        <h2 class="section-title">Elevating Healthcare Billing</h2>
                        <p class="features-desc">We combine decades of experience with proprietary AI technology to deliver unmatched accuracy and speed in your revenue cycle.</p>
                        
                        <ul class="feature-list">
                            <li>
                                <div class="feature-icon-box"><i class="fas fa-robot"></i></div>
                                <div>
                                    <h4>AI-Powered Scrubbing</h4>
                                    <p>Our algorithms catch errors before submission, ensuring a 99% first-pass clean claim rate.</p>
                                </div>
                            </li>
                            <li>
                                <div class="feature-icon-box"><i class="fas fa-user-md"></i></div>
                                <div>
                                    <h4>Specialty-Specific Coders</h4>
                                    <p>AAPC & AHIMA certified experts dedicated exclusively to your medical specialty.</p>
                                </div>
                            </li>
                            <li>
                                <div class="feature-icon-box"><i class="fas fa-globe-americas"></i></div>
                                <div>
                                    <h4>Cross-Border Expertise</h4>
                                    <p>Deep understanding of both USA and Canadian healthcare billing compliance and regulations.</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="features-image">
                        <div class="glass-promo-card">
                            <i class="fas fa-chart-line"></i>
                            <h3>Increase Collections by 20%</h3>
                            <p>Get a free comprehensive analysis of your current billing process.</p>
                            <a href="#consultation" class="btn btn-primary" style="width: 100%; margin-top: 20px;">Get Free Analysis</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Testimonials -->
        <section class="testimonials-section section-padding bg-light">
            <div class="container">
                <div class="section-heading text-center" style="margin: 0 auto 60px;">
                    <span class="section-tag">Testimonials</span>
                    <h2 class="section-title">Hear Directly From Clients</h2>
                </div>
                
                <div class="testimonials-grid">
                    <div class="testimonial-card">
                        <div class="stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                        <p class="quote">"E-nnovationrcm completely transformed our AR. Within 90 days, our outstanding AR dropped by 40% and cash flow has never been better."</p>
                        <div class="author">
                            <h4>Dr. Sarah Jenkins</h4>
                            <span>Family Practice</span>
                        </div>
                    </div>
                    <div class="testimonial-card">
                        <div class="stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                        <p class="quote">"The AI claim scrubbing is a game changer. We rarely see denials anymore, and the team's knowledge of cardiology coding is exceptional."</p>
                        <div class="author">
                            <h4>Mark T.</h4>
                            <span>Clinic Administrator</span>
                        </div>
                    </div>
                    <div class="testimonial-card">
                        <div class="stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                        <p class="quote">"Their support for both our US and Canadian locations has simplified our operations immensely. Highly recommended."</p>
                        <div class="author">
                            <h4>Emily R.</h4>
                            <span>Enterprise Director</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Bottom CTA -->
        <section class="bottom-cta">
            <div class="container text-center">
                <h2>Ready to Optimize Your Revenue?</h2>
                <p>Join 500+ providers who trust us with their revenue cycle management.</p>
                <div style="margin-top: 30px; display: flex; gap: 20px; justify-content: center;">
                    <a href="#consultation" class="btn btn-secondary">Schedule Consultation</a>
                    <a href="#contact" class="btn btn-outline" style="border-color: white; color: white;">Contact Us</a>
                </div>
            </div>
        </section>
    `
};

// Function to generate generic content for any page not specifically defined in the `pages` object
function generatePageContent(id) {
    // Format the ID to a readable title (e.g., 'small-practices' -> 'Small Practices')
    const title = id.split('-').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
    
    return \`
        <div class="page-header">
            <div class="container">
                <h1>\${title}</h1>
                <p>Expert \${title.toLowerCase()} solutions tailored for healthcare providers in the USA and Canada.</p>
            </div>
        </div>
        
        <div class="page-content container">
            <div style="max-width: 800px; margin: 0 auto; line-height: 1.8; color: var(--text-body); font-size: 16px;">
                <h2 style="margin-bottom: 20px; color: var(--primary);">Optimize Your \${title}</h2>
                <p style="margin-bottom: 20px;">At E-nnovationrcm, we understand the unique challenges associated with <strong>\${title.toLowerCase()}</strong>. Our team of certified professionals leverages state-of-the-art AI technology to streamline your workflow, ensure strict HIPAA compliance, and maximize your revenue collections.</p>
                
                <h3 style="margin-bottom: 15px; margin-top: 40px; color: var(--primary);">Why Choose Us for \${title}?</h3>
                <ul style="list-style-type: none; padding-left: 0;">
                    <li style="margin-bottom: 10px; display: flex; align-items: flex-start; gap: 10px;">
                        <i class="fas fa-check-circle" style="color: var(--secondary); margin-top: 5px;"></i>
                        <span><strong>Dedicated Experts:</strong> Our AAPC and AHIMA certified staff are deeply familiar with the nuances of \${title.toLowerCase()}.</span>
                    </li>
                    <li style="margin-bottom: 10px; display: flex; align-items: flex-start; gap: 10px;">
                        <i class="fas fa-check-circle" style="color: var(--secondary); margin-top: 5px;"></i>
                        <span><strong>AI-Powered Efficiency:</strong> We reduce errors and speed up processing times utilizing advanced algorithms.</span>
                    </li>
                    <li style="margin-bottom: 10px; display: flex; align-items: flex-start; gap: 10px;">
                        <i class="fas fa-check-circle" style="color: var(--secondary); margin-top: 5px;"></i>
                        <span><strong>USA & Canada Support:</strong> Unmatched cross-border expertise to ensure your practice thrives regardless of location.</span>
                    </li>
                </ul>
                
                <div style="margin-top: 50px; text-align: center; background: var(--bg-light); padding: 40px; border-radius: 12px;">
                    <h3 style="margin-bottom: 15px;">Ready to elevate your \${title.toLowerCase()}?</h3>
                    <p style="margin-bottom: 25px;">Get a free practice analysis today.</p>
                    <a href="#consultation" class="btn btn-primary">Schedule a Consultation</a>
                </div>
            </div>
        </div>
    \`;
}

// SPA Router Logic
const appContent = document.getElementById('app-content');
const header = document.getElementById('header');

function handleRoute() {
    // Get the hash without the '#' symbol
    let hash = window.location.hash.substring(1);
    
    // Default to 'home' if no hash exists
    if (!hash) {
        hash = 'home';
        window.location.hash = 'home';
    }

    // Scroll to top on route change
    window.scrollTo({ top: 0, behavior: 'smooth' });

    // Load content
    if (pages[hash]) {
        appContent.innerHTML = pages[hash];
    } else {
        // If the page isn't explicitly defined, generate a beautiful template for it
        appContent.innerHTML = generatePageContent(hash);
    }
}

// Header Scroll Effect
window.addEventListener('scroll', () => {
    if (window.scrollY > 10) {
        header.classList.add('scrolled');
    } else {
        header.classList.remove('scrolled');
    }
});

// Listen for hash changes
window.addEventListener('hashchange', handleRoute);

// Initial route handling
window.addEventListener('load', handleRoute);
