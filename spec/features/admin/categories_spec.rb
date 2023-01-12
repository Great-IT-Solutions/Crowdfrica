feature 'Manages categories' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    sign_in admin_user
    visit admin_user_root_path
  end

  scenario 'Create a category' do
    category = build(:new_category)
    click_on 'New Category'
    fill_in 'category_category_name', with: category.category_name
    fill_in 'category_category_description', with: category.category_description
    click_on 'Create Category'
    expect(page).to have_content category.category_name
  end

  scenario 'View all categories' do
    create(:new_category)
    click_on 'Categories'
    expect(page).to have_css('.ul-list-remove-padding', minimum: 1, wait: 1.0)
  end

  scenario 'Update a category' do
    create(:new_category)
    click_on 'Categories'
    click_on 'Update Category'
    fill_in 'Category description', with: 'Updated Category description'
    click_on 'Update Category'
    expect(page).to have_content 'has been successfully updated'
  end

  scenario 'Destroy a category' do
    create(:new_category)
    click_on 'Categories'
    click_on 'Delete'
    expect(page).to have_content 'was successfully deleted'
  end
end
