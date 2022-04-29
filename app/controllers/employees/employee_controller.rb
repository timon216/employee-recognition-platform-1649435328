# frozen_string_literal: true

module Employees
  class EmployeeController < ApplicationController
    before_action :authenticate_employee!

    layout 'employee'
  end
end
