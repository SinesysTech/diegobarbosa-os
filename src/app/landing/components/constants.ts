/**
 * Landing Page Constants
 * Configurações e dados estáticos da landing page
 */

export const BRAND = {
  name: "Diego Barbosa",
  tagline: "Soluções Jurídicas",
  oab: "OAB/SP 123.456",
  email: "contato@diegobarbosa.adv.br",
  phone: "(11) 99999-9999",
  address: "Av. Paulista, 1000 - SP",
  whatsapp: "5511999999999",
} as const;

export const NAV_LINKS = [
  { label: "Como Funciona", href: "#como-funciona" },
  { label: "Áreas de Atuação", href: "#servicos" },
  { label: "Sobre", href: "#sobre" },
] as const;

export const STATS = [
  { value: "500+", label: "Casos Resolvidos" },
  { value: "R$ 2 Mi", label: "Recuperados" },
  { value: "100%", label: "Digital" },
  { value: "5.0", label: "Avaliação", isRating: true },
] as const;

export const SERVICES = [
  {
    id: "passageiro",
    icon: "flight_takeoff",
    title: "Direito do Passageiro",
    description: "Teve seu voo cancelado, atrasado ou bagagem extraviada? Buscamos sua compensação de forma rápida.",
    cta: "Simular Indenização",
    href: "#analise",
  },
  {
    id: "trabalhista",
    icon: "badge",
    title: "Direito Trabalhista",
    description: "Dúvidas sobre rescisão, horas extras ou assédio? Garanta que seus direitos trabalhistas sejam respeitados.",
    cta: "Falar com Advogado",
    href: "#contato",
    featured: true,
    badge: "Mais Procurado",
  },
  {
    id: "consumidor",
    icon: "sell",
    title: "Direito do Consumidor",
    description: "Cobranças indevidas, nome negativado injustamente ou problemas com produtos. Recupere o que é seu.",
    cta: "Analisar Caso",
    href: "#analise",
  },
] as const;

export const STEPS = [
  {
    number: 1,
    icon: "chat",
    title: "Relate seu caso",
    description: "Conte sua história através do nosso formulário ou WhatsApp de forma segura.",
  },
  {
    number: 2,
    icon: "manage_search",
    title: "Análise Especializada",
    description: "Nossa equipe avalia a viabilidade do seu direito em até 24 horas.",
  },
  {
    number: 3,
    icon: "gavel",
    title: "Ação Jurídica",
    description: "Iniciamos o processo administrativo ou judicial necessário.",
  },
  {
    number: 4,
    icon: "account_balance_wallet",
    title: "Receba seu Direito",
    description: "Acompanhe tudo online e receba sua indenização diretamente.",
    isSuccess: true,
  },
] as const;

export const WHY_US_FEATURES = [
  {
    icon: "check",
    title: "Atendimento 100% Online",
    description: "Resolva tudo pelo celular, sem precisar se deslocar até um escritório físico.",
  },
  {
    icon: "check",
    title: "Linguagem Simples",
    description: "Explicamos cada etapa de forma clara. Sem \"juridiquês\" complicado.",
  },
  {
    icon: "check",
    title: "Transparência Total",
    description: "Acesso em tempo real ao andamento do seu caso através do nosso portal.",
  },
] as const;

export const TESTIMONIALS = [
  {
    id: 1,
    name: "Maria S.",
    avatar: "M",
    avatarColor: "bg-orange-100 text-orange-600",
    rating: 5,
    text: "Eu não entendia nada sobre meus direitos trabalhistas. O Dr. Diego explicou tudo de forma muito simples e ganhamos a causa em tempo recorde.",
    date: "Avaliado há 2 semanas",
    type: "google" as const,
  },
  {
    id: 2,
    name: "João Paulo",
    text: "Dr., passando para agradecer. O dinheiro acabou de cair na conta! 🙏 Não imaginava que seria tão rápido.",
    time: "14:32",
    type: "whatsapp" as const,
  },
  {
    id: 3,
    name: "Fernanda Lima",
    avatar: "F",
    avatarColor: "bg-purple-100 text-purple-600",
    rating: 5,
    text: "Transparência total desde o primeiro contato. O sistema deles avisa cada movimentação do processo. Recomendo demais!",
    date: "Avaliado há 1 mês",
    type: "google" as const,
  },
] as const;

export const FOOTER_LINKS = {
  services: [
    { label: "Problemas com Voo", href: "#" },
    { label: "Direito Trabalhista", href: "#" },
    { label: "Direito do Consumidor", href: "#" },
    { label: "Negativação Indevida", href: "#" },
  ],
  institutional: [
    { label: "Sobre Nós", href: "#sobre" },
    { label: "Blog", href: "#" },
    { label: "Política de Privacidade", href: "#" },
    { label: "Termos de Uso", href: "#" },
  ],
  legal: [
    { label: "Política de Privacidade", href: "#" },
    { label: "Termos de Uso", href: "#" },
    { label: "Código de Ética", href: "#" },
  ],
  navigation: [
    { label: "Início", href: "#" },
    { label: "Sobre Nós", href: "#sobre" },
    { label: "Como Funciona", href: "#como-funciona" },
    { label: "Blog Jurídico", href: "#" },
  ],
} as const;
