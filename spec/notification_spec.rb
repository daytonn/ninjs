require "spec_helper"

describe Ninjs::Notification do  
  it 'should have a notify method' do
    Ninjs::Notification.notify('hello', :none).should == 'hello'
  end
  
  it 'should have a notice method' do
    Ninjs::Notification.notice('hello').should === 'hello'
  end
  
  it 'should have a log method' do
    Ninjs::Notification.log('hello').should === "\e[32m>>>\e[0m hello"
  end
  
  it 'should have an event method' do
    Ninjs::Notification.event('hello').should === "\e[33m<<<\e[0m hello"
  end
  
  it 'should have an added method' do
    Ninjs::Notification.added('hello').should === "\e[32m+++\e[0m hello"
  end
  
  it 'should have an error method' do
    Ninjs::Notification.error('hello').should === "\e[0;31m!!!\e[0m hello"
  end
end