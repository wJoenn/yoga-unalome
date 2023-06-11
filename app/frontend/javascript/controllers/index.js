// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CalendarController from "./calendar_controller"
application.register("calendar", CalendarController)

import FlashesController from "./flashes_controller"
application.register("flashes", FlashesController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ToggleHiddenPasswordController from "./toggle_hidden_password_controller"
application.register("toggle-hidden-password", ToggleHiddenPasswordController)

import UserFormModalController from "./user_form_modal_controller"
application.register("user-form-modal", UserFormModalController)

import ContactController from "./contact_controller"
application.register("contact", ContactController)
