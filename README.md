# <u>___Jenkins Cookbook___</u>                

<div>
  <img width="150px;" src="./readmeimg/jenkins.jpeg" alt="FB">
</div>

<p style="font-size: 18px;">This cookbook was created to be able to automatically install Jenkins.</p>

## Contents
---
- <a href="#what" style="font-size: 20px;"> What is Jenkins? </a>
- <a href="#how" style="font-size: 20px;"> How to use this cookbook </a>
- <a href="#tests" style="font-size: 20px;"> Run the tests </a>
---

<u><h2 id="what">What is Jenkins?</h2></u>

<p style="font-size: 18px;">
Jenkins is a DevOps tool used to create Continuous Integration/Continuous Delivery/Continuous Deployment pipelines (CI/CD/CD). The key differences between the 3 pipelines are that:
  <ul style="font-size: 16px;">
    <li>CI - A pipeline that pulls the projects code from a version control systems development branch, tests it using the tests that the developer creates and (should they pass) pushes the code to the UAT/Live branch</li>  
    <li>CD(elivery) - Pulls code from the UAT branch and tests it on a UAT environment. From that UAT machine, if the tests pass, it is pushed to a live production environment.</li>  
    <li>CD(eployment) - Pulls code from the live branch and then deploys it on a live production environment straight away</li>
  </ul>
</p>

<p style="font-size: 18px;">
Jenkins also has several plugins to allow it to communicate with other services such as AWS, GitHub, Mercurial etc.
</p>

<p style="font-size: 18px;">
Jenkins builds are colour coded and can be customised to suit the needs of the developer using it. The default colours are:
  <ul style="font-size: 16px;">
    <li>Blue = Pass</li>
    <li>Red = Fail</li> 
    <li>Grey = Build interrupted/Cancelled</li>
  </ul>
</p>

<u><h2 id="how">How to use this cookbook</h2></u>

### Initial preparation
<p style="font-size: 18px;">
To use this cookbook, Follow these initial steps:
</p>

1. <p style="font-size: 16px;"> Create a Berksfile. </p>

```bash
  touch Berksfile
```

2. <p style="font-size: 16px;"> Open this Berksfile using your chosen file editor. </p>

3. <p style="font-size: 16px;"> Add these lines to the Berksfile. </p>

```ruby
source "https://supermarket.chef.io"

cookbook "jenkins", git: "git@github.com:RCollettSG/JenkinsCookbook.git"
```

4. <p style="font-size: 16px;"> Save the Berksfile and run this line in your console under the same directory it is in. </p>

```bash
  berks vendor cookbooks
```

5. <p style="font-size: 16px;"> If done correctly, a cookbooks directory should appear in the directory you are in, containing the beats cookbook. A Berksfile.lock should also appear. </p>

![file tree](./readmeimg/cbfiletree.png)


### <u>Vagrant</u>
<p style="font-size: 18px;">
To use the cookbook with Vagrant, insert these lines into your Vagrantfile.
</p>

```ruby
db.vm.provision "chef_solo" do |chef|
  chef.add_recipe "jenkins::default"
end
```

### <u>Packer</u>
<p style="font-size: 18px;">
To use the cookbook with Packer, insert these lines into your packer.json file.
</p>

```json
"provisioners": [
    {
      "type": "chef-solo",
      "cookbook_paths": ["./cookbooks"],
      "run_list": ["jenkins::default"]
    }
  ]
```

<u><h2 id="tests">Run the tests</h2></u>
<p style="font-size: 18px;">
ChefSpec has been used to write the unit tests and run them effectively. It has 100% coverage of the code, so all of the methods within the recipe have a corresponding test.
</p>

<p style="font-size: 18px;">
To run these tests, use the following:
</p>

```bash
  chef exec rspec spec
```

<p style="font-size: 18px;">
Inspec has been used to write and test the integration tests. There are tests for package installs, services running and files existing to ensure maximum robustness.
</p>

<p style="font-size: 18px;">
These tests are run using the configuration written in the kitchen.yml, which is using vagrant. It is also pipeline ready, with a kitchen.cloud.yml to enable it to run on an AWS instance within a CI/CD pipeline for automation purposes.
</p>

<p style="font-size: 18px;">
To run these tests, use the following:
</p>

```bash
  kitchen test
```

---
