import type { Metadata } from "next";
import {
  Header,
  Hero,
  TrustBar,
  Services,
  HowItWorks,
  WhyUs,
  Testimonials,
  Cta,
  Footer,
} from "./landing/components";

export const metadata: Metadata = {
  title: "Diego Barbosa - Soluções Jurídicas",
  description:
    "Soluções jurídicas modernas e digitais. Resolvemos problemas de voo, trabalhistas e de consumo de forma 100% online.",
  keywords: [
    "advogado",
    "direito do consumidor",
    "direito trabalhista",
    "problemas com voo",
    "indenização",
    "advocacia digital",
  ],
  openGraph: {
    title: "Diego Barbosa - Soluções Jurídicas",
    description:
      "Resolvemos problemas de voo, questões trabalhistas e direitos do consumidor. Tudo digital, sem burocracia.",
    type: "website",
  },
};

export default function LandingPage() {
  return (
    <main className="scroll-smooth">
      <Header />
      <Hero />
      <TrustBar />
      <Services />
      <HowItWorks />
      <WhyUs />
      <Testimonials />
      <Cta />
      <Footer />
    </main>
  );
}
