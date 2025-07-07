import { Component, OnInit } from '@angular/core';
import { RouterOutlet, Router, NavigationEnd } from '@angular/router';
import { HeaderComponent } from "./header/header.component";
import { FooterComponent } from "./footer/footer.component";
import { SeoService } from './services/seo.service';
import { filter } from 'rxjs/operators';

@Component({
  selector: 'app-root',
  imports: [HeaderComponent, FooterComponent, RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent implements OnInit {
  title = 'avtech-company';

  constructor(
    private seoService: SeoService,
    private router: Router
  ) {}

  ngOnInit(): void {
    // Set default SEO for home page
    this.seoService.updateSEO(this.seoService.getHomeSEO());
    this.seoService.generateStructuredData('Organization');

    // Update SEO on route changes
    this.router.events.pipe(
      filter(event => event instanceof NavigationEnd)
    ).subscribe((event: NavigationEnd) => {
      this.updateSEOBasedOnRoute(event.urlAfterRedirects);
    });
  }

  private updateSEOBasedOnRoute(url: string): void {
    let seoData;
    let structuredDataType = 'Organization';

    switch (true) {
      case url === '/' || url === '/home':
        seoData = this.seoService.getHomeSEO();
        structuredDataType = 'Organization';
        break;
      case url.includes('/services'):
        seoData = this.seoService.getServicesSEO();
        structuredDataType = 'Service';
        break;
      case url.includes('/about'):
        seoData = this.seoService.getAboutSEO();
        break;
      case url.includes('/contact'):
        seoData = this.seoService.getContactSEO();
        break;
      case url.includes('/blog'):
        seoData = this.seoService.getBlogSEO();
        break;
      case url.includes('/career'):
        seoData = this.seoService.getCareerSEO();
        break;
      default:
        seoData = this.seoService.getHomeSEO();
    }

    this.seoService.updateSEO(seoData);
    this.seoService.generateStructuredData(structuredDataType);
  }
}
