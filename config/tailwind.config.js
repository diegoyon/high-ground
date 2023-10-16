const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'hg-purple': '#e81f9b',
        'hg-cyan': '#5ce1e6',
        'hg-black': '#263940'
      },
      animation: {
        'appear': 'appear 3s ease',
        'appear-left': 'appear-left 3s ease',
        'appear-right': 'appear-right 3s ease',
      },
      keyframes: {
        appear: {
          '0%': {
            transform: 'scale(0.8)',
            opacity: 0
          },
          '100%': {
            transform: 'scale(1)',
            opacity: 1
          },
        },
        'appear-left': {
          '0%': {
            transform: 'translateX(-100px)',
            opacity: 0
          },
          '100%': {
            transform: 'translateX(0)',
            opacity: 1
          },
        },
        'appear-right': {
          '0%': {
            transform: 'translateX(100px)',
            opacity: 0
          },
          '100%': {
            transform: 'translateX(0)',
            opacity: 1
          },
        },
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
  safelist: [
    'grid-cols-[1fr_4fr_1fr]',
    'grid-cols-[1fr_4fr_1fr_repeat(1,_2fr)]',
    'grid-cols-[1fr_4fr_1fr_repeat(2,_2fr)]',
    'grid-cols-[1fr_4fr_1fr_repeat(3,_2fr)]',
    'grid-cols-[1fr_4fr_1fr_repeat(4,_2fr)]',
    'grid-cols-[1fr_4fr_1fr_repeat(5,_2fr)]',
    'grid-cols-[1fr_4fr_1fr_repeat(6,_2fr)]',
    'grid-cols-[1fr_4fr_1fr_repeat(7,_2fr)]',
    'grid-cols-[1fr_4fr_1fr_repeat(8,_2fr)]',
    'grid-cols-[1fr_4fr_1fr_repeat(9,_2fr)]',
    'grid-cols-[1fr_4fr_1fr_repeat(10,_2fr)]',
    'grid-cols-1',
    'grid-cols-2',
    'grid-cols-3',
    'grid-cols-4',
    'grid-cols-5',
    'grid-cols-6',
    'grid-cols-7',
    'grid-cols-8',
    'grid-cols-9',
    'grid-cols-10',
  ],
}
