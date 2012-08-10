require 'spec_helper'

describe Modular, ' widgets validation ' do
  it "should be valid if all is OK" do
    widget = Modular.create'container', 
      children: [
        type: 'fake_news_feed'
      ]    
      
    widget.invalid?.should be_false
    widget.valid?.should be_true

    widget.errors.to_a.should be_empty
  end

  it "should be invalid if component is not valid" do
    widget = Modular.create('container', title: 'dsfghaskjfhagsdklfjhaflkasjhflkajshflkajdhfalkjhfaldkjhflkjasdhflkjahflkjsdhflkasdjfhaslkjfhasldkfjhaslkfjhaslkfjhaglkjfhlkjdfhglkjsdfhglkjsdfhgkjsdhglkajfhlkjsdfhlkasjdhflkasdjhfalksdjhflkasdjfhalskjfhaljkfhasldkfjhalskdf')

    widget.invalid?.should be_true
    widget.valid?.should be_false

    widget.errors.to_a.should == ["Title is too long (maximum is 64 characters)"]
  end

  describe "children validation" do
    before :each do 
      @widget = Modular.from_json type: 'container',
        children: [
          {
            type: 'fake_news_feed',
            title: 'dsfghaskjfhagsdklfjhaflkasjhflkajshflkajdhfalkjhfaldkjhflkjasdhflkjahflkjsdhflkasdjfhaslkjfhasldkfjhaslkfjhaslkfjhaglkjfhlkjdfhglkjsdfhglkjsdfhgkjsdhglkajfhlkjsdfhlkasjdhflkasdjhfalksdjhflkasdjfhalskjfhaljkfhasldkfjhalskdf'
            },
          {
            type: 'validated'
          }
        ]
    end

    it "should be valid if everything is ok" do
      widget = Modular.from_json type: 'container',
        children: [
          {
            type: 'fake_news_feed'
          },
          {
            type: 'validated',
            non_existant_property: 'something'
          }
        ]

      widget.invalid?.should be_false
      widget.valid?.should be_true
    end

    it "should be invalid if has invalid children" do
      @widget.invalid?.should be_true
      @widget.valid?.should be_false
    end

    it "should return all errors for any widget" do
      widget = Modular.from_json type: 'fake_news_feed', title: 'dsfghaskjfhagsdklfjhaflkasjhflkajshflkajdhfalkjhfaldkjhflkjasdhflkjahflkjsdhflkasdjfhaslkjfhasldkfjhaslkfjhaslkfjhaglkjfhlkjdfhglkjsdfhglkjsdfhgkjsdhglkajfhlkjsdfhlkasjdhflkasdjhfalksdjhflkasdjfhalskjfhaljkfhasldkfjhalskdf'
      widget.all_errors.should == { '' => ["Title is too long (maximum is 64 characters)" ] }
    end

    it "should return all errors for children correctly if elemnts dont have uids" do
      @widget.errors.to_a.should be_empty
      @widget.all_errors.should == {
        '' => ["Title is too long (maximum is 64 characters)", 'Non existant property can\'t be blank']
      }
    end

    it "should return errors with uniqid" do
      @widget.children.first.uniqid = 'first'
      @widget.errors.to_a.should be_empty
      @widget.all_errors.should == {
        'first' => ["Title is too long (maximum is 64 characters)"],
        '' => ['Non existant property can\'t be blank']
      }
    end

    it "should return all errors with uids" do
      widget = Modular.from_json type: 'container', uniqid: 'first',
        children: [
          {
            uniqid: 'second',
            type: 'fake_news_feed',
            title: 'dsfghaskjfhagsdklfjhaflkasjhflkajshflkajdhfalkjhfaldkjhflkjasdhflkjahflkjsdhflkasdjfhaslkjfhasldkfjhaslkfjhaslkfjhaglkjfhlkjdfhglkjsdfhglkjsdfhgkjsdhglkajfhlkjsdfhlkasjdhflkasdjhfalksdjhflkasdjfhalskjfhaljkfhasldkfjhalskdf'
          },
          {
            type: 'container',
            uniqid: 'fourth',
            title: 'dsfghaskjfhdfgsdfgsdgsdfsdfgsdfgsdfgsddgfdagsdklfjhaflkasjhflkajshflkajdhfalkjhfaldkjhflkjasdhflkjahflkjsdhflkasdjfhaslkjfhasldkfjhaslkfjhaslkfjhaglkjfhlkjdfhglkjsdfhglkjsdfhgkjsdhglkajfhlkjsdfhlkasjdhflkasdjhfalksdjhflkasdjfhalskjfhaljkfhasldkfjhalskdf',
            children: [
              {
                uniqid: 'last',
                type: 'fake_news_feed',
                title: 'dsfghaskjfhagsdklfjhaflkasjhflkajshflkajdhfalkjhfaldkjhflkjasdhflkjahflkjsdhflkasdjfhaslkjfhasldkfjhaslkfjhaslkfjhaglkjfhlkjdfhglkjsdfhglkjsdfhgkjsdhglkajfhlkjsdfhlkasjdhflkasdjhfalksdjhflkasdjfhalskjfhaljkfhasldkfjhalskdf'
              }
            ]
          },
          {
            uniqid: 'third',
            type: 'validated'
          }
        ]

      widget.all_errors.should == {
        'second' => ["Title is too long (maximum is 64 characters)"],
        'last' => ["Title is too long (maximum is 64 characters)"],
        'fourth' => ["Title is too long (maximum is 64 characters)"],
        'third' => ['Non existant property can\'t be blank']
      }
    end
  end
end