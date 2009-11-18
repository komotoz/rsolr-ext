class RSolrExtConnectionTest < Test::Unit::TestCase
  
  test 'the #connect method' do
    connection = RSolr::Ext.connect
    assert connection.respond_to?(:find)
  end
  
  test 'the #find method' do
    connection = RSolr::Ext.connect
    response = connection.find :page=>3, :per_page=>10, :q=>'*:*'#, :page=>1, :per_page=>10
    assert response.kind_of?(Mash)
  end
  
  test 'the #find method with a custom request handler' do
    connection = RSolr::Ext.connect
    response = connection.find '/select', :q=>'*:*'
    assert response.raw[:path]=~/\/select/
  end
  
  test 'the response' do
    connection = RSolr::Ext.connect
    response = connection.find :q=>'*:*'
    assert response.respond_to?(:ok?)
    assert response.ok?
    assert_equal response.docs[0][:id], response.docs[0].id
  end
  
  test 'the #luke method' do
    info = RSolr::Ext.connect.luke
    assert info.kind_of?(Mash)
    assert info.key?('fields')
    assert info.key?('index')
    assert info.key?('info')
  end
  
end