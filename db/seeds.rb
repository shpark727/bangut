# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



	Term.create( [ term_code: '1.0', term_content: 'this is terms version1.'] )
	Term.create( [ term_code: '1.1', term_content: 'this is terms version1.1'])

	UnivCategory.create( [univ_name: 'ajou']) 
	UnivCategory.create( [univ_name: 'korea'])
	UnivCategory.create( [univ_name: 'seoul'])


