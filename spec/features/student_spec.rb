require 'rails_helper'


describe 'form page' do
  it 'form renders with the new action' do
    visit new_student_path
    expect(page).to have_content("Student Form")
  end

  it 'new form submits content and renders form content' do
    visit new_student_path

    fill_in 'first_name', with: "Lindsey"
    fill_in 'last_name', with: "Stirling"

    click_on "Create student"

    expect(page).to have_content("Lindsey")
  end

  it 'submitted edit form submits content and renders form content' do
    let(:edit_student) { FactoryGirl.create(:student) }

    visit student_path(edit_student)

    fill_in 'first_name', with: "Lindsey"
    fill_in 'last_name', with: "Stirling"

    click_on "Update student"

    expect(page).to have_content("Lindsey")
  end

  it 'creates a record in the database' do
    visit new_student_path

    fill_in 'first_name', with: "Sansa"
    fill_in 'last_name', with: "Stark"

    click_on "Create student"

    expect(Student.last.first_name).to eq("Sansa")
  end

  it 'submitted edit form creates a record in the database' do
    let(:edit_db_student) { FactoryGirl.create(:student) }

    visit student_path(edit_db_student)

    fill_in 'first_name', with: "Arya"
    fill_in 'last_name', with: "Stark"

    click_on "Update student"

    expect(Student.last.first_name).to eq("Arya")
  end
end

describe 'Show page' do
  let(:student) { FactoryGirl.create(:student) }

  it 'renders properly' do
    visit student_path(student)
    expect(page.status_code).to eq(200)
  end

  it 'renders the student first_name' do
    visit student_path(student)
    expect(page).to have_content("Daenerys")
  end
end