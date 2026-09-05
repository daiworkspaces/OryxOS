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
    ['meta', { name: 'theme-color', content: '#0a0c10' }],
    ['meta', { name: 'keywords', content: 'OryxOS, Agent OS, Agent Harness, enterprise AI agents, ReAct, MCP, Java, self-hosted AI' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:site_name', content: 'OryxOS' }],
    ['meta', { property: 'og:title', content: 'OryxOS — Give intent. Get outcomes.' }],
    ['meta', { property: 'og:description', content: 'One directory defines one Agent. One self-hosted foundation runs the fleet.' }],
    ['meta', { property: 'og:image', content: '/og.png' }],
    ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
    ['meta', { name: 'twitter:image', content: '/og.png' }],
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
          { text: 'GitHub ↗', link: 'https://github.com/daiworkspaces/OryxOS.git' },
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
          { text: 'GitHub ↗', link: 'https://github.com/daiworkspaces/OryxOS.git' },
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
    socialLinks: [{ icon: 'github', link: 'https://github.com/daiworkspaces/OryxOS.git' }],
    search: { provider: 'local' },
  },

})
