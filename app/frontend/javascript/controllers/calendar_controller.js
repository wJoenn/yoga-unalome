import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar"
export default class extends Controller {
  static targets = ["month", "days", "previous", "next"]

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

  #createHtml(currentDay, numberOfDays, previousMonth, nextMonth, date) {
    this.daysTarget.innerHTML = ""

    // We add one day for each visible day of the previous month
    const numberOfDaysLastMonth = this.#getNumberOfDays(date, 0)
    for (let i = numberOfDaysLastMonth; i > numberOfDaysLastMonth - previousMonth; i--) {
      const html = `<li class="off">${i}</li$>`
      this.daysTarget.insertAdjacentHTML("afterBegin", html)
    }

    // Then one day for each day of the month and we add a class of current for today
    for (let i = 1; i <= numberOfDays; i++) {
      const html = `<li${i === currentDay ? " class='current'" : ""}>${i}</li$>`
      this.daysTarget.insertAdjacentHTML("beforeEnd", html)
    }

    // Then we add one day for each visible day of next month
    for (let i = 1; i <= nextMonth; i++) {
      const html = `<li class="off">${i}</li$>`
      this.daysTarget.insertAdjacentHTML("beforeEnd", html)
    }
  }

  #getNumberOfDays(date, offset) {
    const year = date.getFullYear()
    const month = date.getMonth() + offset

    return new Date(year, month, 0).getDate()
  }

  #getDay(date, day) {
    const year = date.getFullYear()
    let month = date.getMonth()

    // When day is 0 it's because we want the last day of the month so as for #getNumberOfDays we need to increment the
    // current month by 1.
    if (day === 0) month++

    // getDay return the day of the week, it's different from getDate which return the day of the month
    // Also getDay returns sundays as 0 but in belgium sunday is 7, that's why I change that.
    let weekDay = new Date(year, month, day).getDay()
    weekDay = weekDay === 0 ? 7 : weekDay

    return weekDay
  }

  #updateButtons() {
    if (this.currentMonth === this.month) this.previousTarget.disabled = true
    if (this.month >= this.currentMonth + 4) this.nextTarget.disabled = true
  }

  #updateDays(date) {
    const currentDay = this.today.getDate()

    // The way to get how many days are in a month is just to create a new Date with a day of 0 and that gives you the
    // number of the previous' month. Just need to use the next month and we'll get the last day of the current one.
    const numberOfDays = this.#getNumberOfDays(date, 1)

    // We'll need those numbers to display greyed out days for the previous and next month if they're in the same
    // week other days in the current month.
    const visibleDaysOfPreviousMonth = this.#getDay(date, 1) - 1
    const visibleDayOfNextMonth = 7 - this.#getDay(date, 0)

    this.#createHtml(currentDay, numberOfDays, visibleDaysOfPreviousMonth, visibleDayOfNextMonth, date)
  }

  #updateMonth(offset) {
    this.month += offset
    const date = new Date(this.today.getFullYear(), this.month, 1)
    const month = date.toLocaleDateString("en-UK", { month: "long" })
    this.monthTarget.innerText = month

    return date
  }
}
