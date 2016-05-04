# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



	Term.create( [ term_code: '1.0', term_content: 'this is terms version 1.0'] )
	Term.create( [ term_code: '1.1', term_content: 'this is terms version 1.1'])

	RewardItem.create( [ item_code: '0', name: 'no_item', price: '0']) 
	RewardItem.create( [ item_code: '1', name: 'pop_corn', price: '1500'])
	RewardItem.create( [ item_code: '2', name: 'americano', price: '4100'])
	RewardItem.create( [ item_code: '3', name: 'ice_americano', price: '4100'])
	RewardItem.create( [ item_code: '4', name: 'gift_ticket', price: '5000'])

	PayTerm.create( [ term_code: '1.0', term_content: 'this is pay_term vision1.0'] )

	UnivCategory.create( [univ_name: '아주대학교']) 
	UnivCategory.create( [univ_name: '고려대학교'])
	UnivCategory.create( [univ_name: '서울대학교'])


