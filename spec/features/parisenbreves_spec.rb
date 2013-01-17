#!/usr/bin/env ruby -w
# encoding: UTF-8

require 'spec_helper'

feature "Breves list" do
	scenario "display some breves" do
	  visit breves_path
	  page.should have_content 'une breve'
	end
end
