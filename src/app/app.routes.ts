import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { AboutComponent } from './pages/about/about.component';
import { ContactComponent } from './pages/contact/contact.component';
import { CareerComponent } from './pages/career/career.component';
import { ServicesComponent } from './pages/services/services.component';
import { BlogComponent } from './pages/blog/blog.component';
import { WebDevelopmentComponent } from './pages/services/web-development/web-development.component';
import { MobileAppDevelopmentComponent } from './pages/services/mobile-app-development/mobile-app-development.component';
import { CloudSolutionsComponent } from './pages/services/cloud-solutions/cloud-solutions.component';
import { DigitalMarketingComponent } from './pages/services/digital-marketing/digital-marketing.component';
import { UiUxDesignComponent } from './pages/services/ui-ux-design/ui-ux-design.component';
import { ConsultingComponent } from './pages/services/consulting/consulting.component';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'about', component: AboutComponent },
  { path: 'contact', component: ContactComponent },
  { path: 'career', component: CareerComponent },
  { path: 'services', component: ServicesComponent },
  { path: 'services/web-development', component: WebDevelopmentComponent },
  { path: 'services/mobile-app-development', component: MobileAppDevelopmentComponent },
  { path: 'services/cloud-solutions', component: CloudSolutionsComponent },
  { path: 'services/digital-marketing', component: DigitalMarketingComponent },
  { path: 'services/ui-ux-design', component: UiUxDesignComponent },
  { path: 'services/consulting', component: ConsultingComponent },
  { path: 'blog', component: BlogComponent },
  { path: '**', redirectTo: '' }
];  
