# MongoDB Template

An [IBM Cloud Schematics](https://cloud.ibm.com/docs/services/schematics?topic=schematics-getting-started) template that allocates a virtual machine instance and provisions MongoDB onto that instance.

Schematics uses [Terraform](https://www.terraform.io/) as the infrastructure as code engine. With this template, you can provision and manage infrastructure as a single unit.

See the [Terraform provider docs](https://ibm-cloud.github.io/tf-ibm-docs/) for available resources for the IBM Cloud. **Note**: To create the resources that this template requests, your [IBM Cloud Infrastructure (Softlayer) account](https://cloud.ibm.com/docs/iam?topic=iam-mngclassicinfra#managing-infrastructure-access) and [IBM Cloud account](https://cloud.ibm.com/docs/iam/mngiam.html#iammanidaccser) must have sufficient permissions.


## Create an environment with this template

Environments can be used to separate software components into development tiers (e.g. staging, QA, and production).

1. In IBM Cloud, go to the menu and select the [Schematics dashboard](https://cloud.ibm.com/schematics).
2. In the left navigation menu, select **Templates** to access the template catalog.
3. Click **Create** on the MongoDB template. You are taken to a configuration page where you can define metadata about your environment.
4. In the **Variables** section:
  a. If you want to be able to SSH into the virtual machine provide a value for `public_key`, `private_key`
5. Define values for your variables according to the following table.

## Variables

|Variable Name|Description|Default Value|
|-------------|-----------|-------------|
|cores|The number of CPU cores to allocate.|1|
|datacenter   |Which data center the VM is to be provisioned in. You can run `ic cs zones` to see a list of all data centers in your region.|wdc01|
|disk_size|Numeric disk sizes in GBs.|25|
|domain       |Domain for the computing instance.|domain.dev|
|hostname     |Hostname for the computing instance.|hostname|
|install_script|The relative location of the Mongo DB install script.|files/installMongoDB.sh|
|memory|The amount of memory to allocate, expressed in megabytes.|1026|
|network_speed|The connection speed (in Mbps) for the instance’s network components.|100|
|os_reference_code|An operating system reference code that is used to provision the computing instance. [Get a complete list of the OS reference codes available](https://api.softlayer.com/rest/v3/SoftLayer_Virtual_Guest_Block_Device_Template_Group/getVhdImportSoftwareDescriptions.json?objectMask=referenceCode) (use your API key as the password to log in).|CENTOS_7|
|private_network_only|When set to `true`, a compute instance only has access to the private network.|false|
|public_key|Your public SSH key to use for access to virtual machine.||
|private_key|Your private SSH key to use for access to virtual machine.||
|ssh_label|An identifying label to assign to the SSH key.|public ssh key - Schematics VM|
|ssh_notes|Notes to store with the SSH key.||
|ssh_user|The provisioning user name.|root|
|tags|Set tags on the VM instance. Permitted characters include: A-Z, 0-9, whitespace, _ (underscore), - (hyphen), . (period), and : (colon). All other characters are removed.||

## Next steps

After setting up your environment with this template, you can run **Plan** to preview how Schematics will deploy resources to your environment. When you are ready to deploy the cluster, run **Apply**.
