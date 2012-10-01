class Object
  def self.implements_role(name)
    context "implements the #{name} role by" do
      RSpec::Roles.roles[name].each do |method_name, parameters|
        required_count = parameters.size
        it "responding to #{method_name} with the #{required_count} required arguments" do
          subject.should respond_to(method_name)
          subject.method(method_name).parameters.size.should == required_count
        end
      end
    end
  end
end

