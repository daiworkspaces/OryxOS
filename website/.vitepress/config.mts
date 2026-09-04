import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'OryxOS',
  titleTemplate: ':title — OryxOS',
  description: 'The self-hosted Agent Harness OS for enterprise Agent fleets, starting with a reliable single-node kernel.',
  base: '/',
  cleanUrls: true,
  appearance: 'dark',
  lastUpdated: true,

  head: [
    ['link', { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' }],
    ['link', { rel: 'preconnect', href: 'https://fonts.googleapis.com' }],
    ['link', { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' }],
    ['link', { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;600&family=Manrope:wght@400;500;600;700;800&display=swap' }],
    ['meta', { name: 'theme-color', content: '#0a0c10' }],
    ['meta', { name: 'keywords', content: 'OryxOS, Agent OS, Agent Harness, enterprise AI agents, ReAct, MCP, Java, self-hosted AI' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:site_name', content: 'OryxOS' }],
    ['meta', { property: 'og:title', content: 'OryxOS — Give intent. Get outcomes.' }],
    ['meta', { property: 'og:description', content: 'One directory defines one Agent. One self-hosted foundation runs the fleet.' }],
    ['meta', { property: 'og:url', content: 'https://oryxos.robustmq.com' }],
    ['meta', { property: 'og:image', content: 'https://oryxos.robustmq.com/og.png' }],
    ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
    ['meta', { name: 'twitter:image', content: 'https://oryxos.robustmq.com/og.png' }],
    ['link', { rel: 'canonical', href: 'https://oryxos.robustmq.com' }],
  ],

  locales: {
    root: {
      label: 'English',
      lang: 'en-US',
      themeConfig: {
        nav: [
          { text: 'Home', link: '/' },
          { text: 'What is OryxOS', link: '/docs/what' },
          { text: 'Architecture', link: '/#architecture' },
          { text: 'Demo', link: 'http://demo.robustmq.com:1524/admin/' },
          { text: 'GitHub ↗', link: 'https://github.com/oryx-labs/oryxos' },
        ],
        sidebar: {
          '/docs/': [
            { text: 'Introduction', items: [{ text: 'What is OryxOS', link: '/docs/what' }] },
          ],
        },
      },
    },
    zh: {
      label: '中文',
      lang: 'zh-CN',
      link: '/zh/',
      themeConfig: {
        nav: [
          { text: '首页', link: '/zh/' },
          { text: 'OryxOS 是什么', link: '/zh/docs/what' },
          { text: '架构', link: '/zh/#architecture' },
          { text: '体验', link: 'http://demo.robustmq.com:1524/admin/' },
          { text: 'GitHub ↗', link: 'https://github.com/oryx-labs/oryxos' },
        ],
        sidebar: {
          '/zh/docs/': [
            { text: '介绍', items: [{ text: 'OryxOS 是什么', link: '/zh/docs/what' }] },
          ],
        },
      },
    },
  },

  themeConfig: {
    siteTitle: 'OryxOS',
    socialLinks: [{ icon: 'github', link: 'https://github.com/oryx-labs/oryxos' }],
    search: { provider: 'local' },
  },

  sitemap: {
    hostname: 'https://oryxos.robustmq.com',
  },
})
