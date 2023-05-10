import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar"
export default class extends Controller {
  static targets = ["month", "days", "previous", "next"]

  static values = {
    sessions: Array
  }

  connect() {
    this.today = new Date()

    // I wanna block the next button after iterating through a few months because there's no point in booking a session
    // in 6 months, Chloe probably doesn't even know what she'll do by then anyway. That's why I'm storing the current
    // month in a variable
    this.currentMonth = this.today.getMonth()
    this.month = this.currentMonth

    // This is triggering the whole calendar building process
    this.#buildCalendar(0)
  }

  handleClick(event) {
    const offset = event.currentTarget.dataset.offset
    this.previousTarget.disabled = false
    this.nextTarget.disabled = false

    this.#buildCalendar(+offset)
  }

  #buildCalendar(offset) {
    // The offset is used to changed the month being shown when clicking on buttons
    // The method returns a Date with the new month instead of today's date
    const date = this.#updateMonth(offset)

    this.#updateDays(date)

    this.#updateButtons()
  }

  #createHtml(numberOfDays, previousMonth, date) {
    this.daysTarget.innerHTML = ""

    // We add one empty li for each day of the previous month in the first week
    const numberOfDaysLastMonth = this.#getNumberOfDays(date, 0)
    for (let i = numberOfDaysLastMonth; i > numberOfDaysLastMonth - previousMonth; i--) {
      const html = "<li class='off'></li$>"
      this.daysTarget.insertAdjacentHTML("afterBegin", html)
    }

    // Then one day for each day of the month and we add a class of "off" to days that have passed
    for (let i = 1; i <= numberOfDays; i++) {
      const htmlClass = this.#getHtmlClass(i)
      const html = `<li class="${htmlClass}">${i}</li$>`
      this.daysTarget.insertAdjacentHTML("beforeEnd", html)
    }
  }

  #getFirstDay(date) {
    const year = date.getFullYear()
    const month = date.getMonth()

    // getDay return the day of the week, it's different from getDate which return the day of the month
    // Also getDay returns sundays as 0 but in belgium sunday is 7, that's why I change that.
    let weekDay = new Date(year, month, 1).getDay()
    weekDay = weekDay === 0 ? 7 : weekDay

    return weekDay
  }

  #getHtmlClass(day) {
    const dayDate = new Date(this.today.getFullYear(), this.month, day)
    let htmlClass = ""

    if (dayDate < this.today) {
      htmlClass = "off"
    } else if (this.sessionsValue.includes(dayDate.toISOString().slice(0, 10))) {
      htmlClass = "session"
    }

    return htmlClass
  }

  #getNumberOfDays(date, offset) {
    const year = date.getFullYear()
    const month = date.getMonth() + offset

    return new Date(year, month, 0).getDate()
  }

  #updateButtons() {
    if (this.currentMonth === this.month) this.previousTarget.disabled = true
    if (this.month >= this.currentMonth + 4) this.nextTarget.disabled = true
  }

  #updateDays(date) {
    // The way to get how many days are in a month is just to create a new Date with a day of 0 and that gives you the
    // number of the previous' month. Just need to use the next month and we'll get the last day of the current one.
    const numberOfDays = this.#getNumberOfDays(date, 1)

    // We'll need this number to position the first day of the month in the correct column
    const firstDayOfTheMonth = this.#getFirstDay(date)
    const daysBeforeFirstDay = firstDayOfTheMonth - 1

    this.#createHtml(numberOfDays, daysBeforeFirstDay, date)
  }

  #updateMonth(offset) {
    this.month += offset
    const date = new Date(this.today.getFullYear(), this.month, 1)
    const month = date.toLocaleDateString("en-UK", { month: "long" })
    this.monthTarget.innerText = month

    return date
  }
}
