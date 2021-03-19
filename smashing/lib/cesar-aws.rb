require 'aws-sdk-ec2'

class Instance
  def initialize(instance)
    @instance = instance
  end

  def tag_value(tag_key)
    @instance.tags.each do |tag|
      if tag_key == tag.key
        return tag.value
      end
    end
    return ""
  end

  def environment
    return self.tag_value("Environment")
  end

  def project
    return self.tag_value("Project")
  end

  def name
    return self.tag_value("Name")
  end

  def state
    return @instance.state.name
  end

  def id
    return @instance.id
  end

end


class Environment
  def initialize(name)
    @name=name
    @instances = {}
  end

  def add_instance(instance)
    name = instance.name
    @instances[name] = instance
  end  
  
  def name
    return @name
  end

  def instances
    return @instances
  end

end

class CesarAws 

  def initialize(region)
    @region = region
    self.load_environments()
  end

  def load_environments()
    @ec2_resource = Aws::EC2::Resource.new(region: @region)
    @instances = @ec2_resource.instances
    @interesting_keys = ['Environment']
    @environments = {}

    if @instances.count.zero?
      puts 'No instances found.'
    end

    # Fill structure
    @instances.each do |instance|
      self.update_environment(instance)
    end
    # Environment.status (available/free or in use)
    # Environments['prod-eu'].instance.name
    # Environments['prod-eu'].instance.id
    # Environments['prod-eu'].instance.state
  end


  def update_environment(instance)
    i = Instance.new(instance)
    environment_name = i.environment
    project_name = i.project
    instance_name = i.name
    if @environments.has_key?(environment_name)
      # Existing environment
      environment = @environments[environment_name]
    else
      # New environment
      environment = Environment.new(environment_name)
    end
    environment.add_instance(i)
    @environments[environment_name] = environment
  end

  def environments()
    return @environments
  end
end

if $PROGRAM_NAME == __FILE__
  region = 'eu-west-1'
  cesar = CesarAws.new(region)
  envs = cesar.environments
  envs.each do |name, envi|
    puts "==#{name}=="
    envi.instances.each do |name,instance|
      puts "  name = #{instance.name} #{instance.id} #{instance.state}"
    end
  end  
end