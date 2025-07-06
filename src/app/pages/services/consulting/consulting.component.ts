import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-consulting',
  standalone: true,
  imports: [RouterLink],
  template: `
    <div class="service-detail-page">
      <div class="service-hero">
        <div class="container">
          <h1 class="service-title">Consulting</h1>
          <p class="service-subtitle">Strategic technology consulting to help your business make informed decisions and achieve digital transformation</p>
        </div>
      </div>
      <div class="service-content">
        <div class="container">
          <section class="service-overview">
            <h2>Expert Technology Consulting</h2>
            <p>AVtech's consulting team brings deep technical expertise and industry knowledge to help businesses navigate complex technology challenges and opportunities. We provide strategic guidance for digital transformation initiatives.</p>
            <div class="services-grid">
              <div class="service-card">
                <h3>🎯 Digital Strategy</h3>
                <p>Develop comprehensive digital transformation strategies aligned with your business goals</p>
              </div>
              <div class="service-card">
                <h3>🏗️ Technology Architecture</h3>
                <p>Design scalable and robust technology architectures for enterprise applications</p>
              </div>
              <div class="service-card">
                <h3>⚡ Performance Optimization</h3>
                <p>Analyze and optimize existing systems for better performance and efficiency</p>
              </div>
              <div class="service-card">
                <h3>🔒 Security Assessment</h3>
                <p>Comprehensive security audits and recommendations to protect your digital assets</p>
              </div>
              <div class="service-card">
                <h3>📊 Technology Roadmap</h3>
                <p>Create detailed technology roadmaps to guide your digital transformation journey</p>
              </div>
              <div class="service-card">
                <h3>🎓 Training & Mentoring</h3>
                <p>Provide technical training and mentoring to upskill your development teams</p>
              </div>
            </div>
          </section>
          <section class="cta-section">
            <div class="cta-content">
              <h2>Need Expert Technology Guidance?</h2>
              <p>Let's discuss your technology challenges and create a strategy for success.</p>
              <div class="cta-buttons">
                <a routerLink="/contact" class="cta-btn primary">Get Started</a>
                <a href="tel:+919793134372" class="cta-btn secondary">Call Us</a>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .service-detail-page { min-height: 100vh; background: #f8f9fa; }
    .service-hero { background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%); color: white; padding: 8rem 0 4rem; text-align: center; }
    .service-title { font-size: 3rem; font-weight: bold; margin-bottom: 1rem; }
    .service-subtitle { font-size: 1.2rem; max-width: 600px; margin: 0 auto; opacity: 0.9; line-height: 1.6; }
    .container { max-width: 1200px; margin: 0 auto; padding: 0 2rem; }
    .service-content { padding: 4rem 0; }
    .service-overview { margin-bottom: 4rem; }
    .service-overview h2 { font-size: 2.5rem; color: #2c3e50; margin-bottom: 1.5rem; text-align: center; }
    .service-overview p { font-size: 1.1rem; line-height: 1.8; color: #666; margin-bottom: 3rem; text-align: center; }
    .services-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 2rem; }
    .service-card { background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); transition: transform 0.3s ease; }
    .service-card:hover { transform: translateY(-5px); }
    .service-card h3 { font-size: 1.5rem; color: #2c3e50; margin-bottom: 1rem; }
    .service-card p { color: #666; line-height: 1.6; }
    .cta-section { background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%); color: white; padding: 4rem 0; border-radius: 12px; text-align: center; }
    .cta-content h2 { font-size: 2.5rem; margin-bottom: 1rem; }
    .cta-content p { font-size: 1.2rem; margin-bottom: 2rem; opacity: 0.9; }
    .cta-buttons { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }
    .cta-btn { padding: 1rem 2rem; border-radius: 50px; text-decoration: none; font-weight: bold; transition: all 0.3s ease; display: inline-block; }
    .cta-btn.primary { background: white; color: #2ecc71; }
    .cta-btn.primary:hover { background: #f8f9fa; transform: translateY(-2px); }
    .cta-btn.secondary { background: transparent; color: white; border: 2px solid white; }
    .cta-btn.secondary:hover { background: white; color: #2ecc71; }
    @media (max-width: 768px) {
      .service-title { font-size: 2rem; }
      .service-subtitle { font-size: 1rem; }
      .service-overview h2 { font-size: 2rem; }
      .services-grid { grid-template-columns: 1fr; gap: 1.5rem; }
      .cta-content h2 { font-size: 2rem; }
      .cta-buttons { flex-direction: column; align-items: center; }
    }
  `]
})
export class ConsultingComponent {

}
