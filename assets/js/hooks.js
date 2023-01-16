let Hooks = {}
Hooks.DarkMode = {
  mounted() {
    let darkModeMediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
    let isSystemDarkMode = darkModeMediaQuery.matches

    this.pushEvent("view:dark-mode", {systemDarkMode: isSystemDarkMode})
  }
}

Hooks.ModeToggle = {
  mounted() {
    function disableTransitionsTemporarily() {
      document.documentElement.classList.add('[&_*]:!transition-none')
      window.setTimeout(() => {
        document.documentElement.classList.remove('[&_*]:!transition-none')
      }, 0)
    }

    function toggleMode() {
      disableTransitionsTemporarily()

      let darkModeMediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
      let isSystemDarkMode = darkModeMediaQuery.matches
      let isDarkMode = document.documentElement.classList.toggle('dark')

      if (isDarkMode === isSystemDarkMode) {
        delete window.localStorage.isDarkMode
      } else {
        window.localStorage.isDarkMode = isDarkMode
      }
    }

    const currentDarkMode = document.documentElement.classList.contains('dark');
    const userDarkMode = window.localStorage.isDarkMode;

    if (userDarkMode !== undefined && userDarkMode !== currentDarkMode) {
      document.documentElement.classList.toggle('dark');
    }

    this.el.addEventListener("click", toggleMode)
  }
}

Hooks.HomepageAvatar = {
  isInitial: true,
  downDelay: 0,
  upDelay: 0,

  setProperty(property, value) {
    document.documentElement.style.setProperty(property, value)
  },

  removeProperty(property) {
    document.documentElement.style.removeProperty(property)
  },

  updateHeaderStyles() {
    isInitial = this.isInitial
    downDelay = this.downDelay
    upDelay = this.upDelay

    const { top, height } = document.getElementById("header-menu").getBoundingClientRect()
    const scrollY = this.clamp(
      window.scrollY,
      0,
      document.body.scrollHeight - window.innerHeight
    )

    if (isInitial) {
      this.setProperty('--header-position', 'sticky')
    }

    this.setProperty('--content-offset', `${downDelay}px`)

    if (isInitial || scrollY < downDelay) {
      this.setProperty('--header-height', `${downDelay + height}px`)
      this.setProperty('--header-mb', `${-downDelay}px`)
    } else if (top + height < -upDelay) {
      let offset = Math.max(height, scrollY - upDelay)
      this.setProperty('--header-height', `${offset}px`)
      this.setProperty('--header-mb', `${height - offset}px`)
    } else if (top === 0) {
      this.setProperty('--header-height', `${scrollY + height}px`)
      this.setProperty('--header-mb', `${-scrollY}px`)
    }

    if (top === 0 && scrollY > 0 && scrollY >= downDelay) {
      this.setProperty('--header-inner-position', 'fixed')
      this.removeProperty('--header-top')
      this.removeProperty('--avatar-top')
    } else {
      this.removeProperty('--header-inner-position')
      this.setProperty('--header-top', '0px')
      this.setProperty('--avatar-top', '0px')
    }
  },

  clamp(number, a, b) {
    let min = Math.min(a, b)
    let max = Math.max(a, b)
    return Math.min(Math.max(number, min), max)
  },

  updateAvatarStyles() {
    const { downDelay } = this

    let fromScale = 1
    let toScale = 36 / 64
    let fromX = 0
    let toX = 2 / 16

    let scrollY = downDelay - window.scrollY

    let scale = (scrollY * (fromScale - toScale)) / downDelay + toScale
    scale = this.clamp(scale, fromScale, toScale)

    let x = (scrollY * (fromX - toX)) / downDelay + toX
    x = this.clamp(x, fromX, toX)

    this.setProperty(
      '--avatar-image-transform',
      `translate3d(${x}rem, 0, 0) scale(${scale})`
    )

    let borderScale = 1 / (toScale / scale)
    let borderX = (-toX + x) * borderScale
    let borderTransform = `translate3d(${borderX}rem, 0, 0) scale(${borderScale})`

    this.setProperty('--avatar-border-transform', borderTransform)
    this.setProperty('--avatar-border-opacity', scale === toScale ? 1 : 0)
  },

  updateStyles() {
    this.updateHeaderStyles()
    this.updateAvatarStyles()
    isInitial = false
  },

  mounted() {
    this.updateStyles = this.updateStyles.bind(this)
    this.updateHeaderStyles = this.updateHeaderStyles.bind(this)
    this.updateAvatarStyles = this.updateAvatarStyles.bind(this)
    // the avatar magic on the hompage
    this.downDelay = this.el.offsetTop ?? 0
    this.upDelay = 64

    this.isInitial = true;

    // hook for menu on homepage
    this.updateStyles()

    window.addEventListener('scroll', this.updateStyles, { passive: true })
    window.addEventListener('resize', this.updateStyles)
  },
  destroyed() {
    window.removeEventListener('scroll', this.updateStyles, { passive: true })
    window.removeEventListener('resize', this.updateStyles)
  }
}

export default Hooks;
