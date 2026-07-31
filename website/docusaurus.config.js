// @ts-check
const { themes: prismThemes } = require('prism-react-renderer');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "Cyril's NixOS Dotfiles",
  tagline: 'Documentation for my personal NixOS + home-manager flake',
  favicon: 'img/favicon.ico',

  url: 'https://docs.itzemoji.com',
  baseUrl: '/',

  organizationName: 'ItzEmoji',
  projectName: 'nixos-dotfiles',

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          routeBasePath: '/',
          sidebarPath: require.resolve('./sidebars.js'),
          editUrl: 'https://github.com/ItzEmoji/nixos-dotfiles/edit/main/website/',
        },
        blog: false,
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      image: 'img/docusaurus-social-card.jpg',
      navbar: {
        title: 'nixos-dotfiles',
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'docsSidebar',
            position: 'left',
            label: 'Docs',
          },
          {
            href: 'https://github.com/ItzEmoji/nixos-dotfiles',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Repository',
            items: [
              { label: 'GitHub', href: 'https://github.com/ItzEmoji/nixos-dotfiles' },
              { label: 'GitLab mirror', href: 'https://gitlab.com/ItzEmoji/nixos-dotfiles' },
              { label: 'Codeberg mirror', href: 'https://codeberg.org/ItzEmoji/nixos-dotfiles' },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Cyril Dettling.`,
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
        additionalLanguages: ['nix', 'bash', 'toml'],
      },
    }),
};

module.exports = config;
