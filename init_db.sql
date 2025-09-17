-- Initialize database with sample questions
-- Create tables if they don't exist
CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    question_text TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL,
    correct_answer CHAR(1) NOT NULL,
    difficulty_level INTEGER NOT NULL,
    category VARCHAR(50),
    subcategory VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS quiz_results (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    score INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    category VARCHAR(50),
    subcategory VARCHAR(50),
    duration_seconds INTEGER DEFAULT 0
);

-- Python Basics
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is the output of print(2 ** 3 ** 2)?', '64', '512', '256', 'Syntax Error', 'B', 2, 'Python', 'Basics'),
('Which of these is a valid variable name?', '2var', 'var-name', '_var', 'var name', 'C', 1, 'Python', 'Basics'),
('What does the // operator do?', 'Floor division', 'Comment', 'Exponentiation', 'String concatenation', 'A', 1, 'Python', 'Basics'),
('Which data type is mutable?', 'tuple', 'string', 'list', 'int', 'C', 1, 'Python', 'Basics'),
('What is the result of bool("False")?', 'False', 'True', 'Error', 'None', 'B', 2, 'Python', 'Basics');

-- Python Flow Control
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What does break do in a loop?', 'Skips current iteration', 'Exits the loop', 'Continues to next iteration', 'Restarts the loop', 'B', 1, 'Python', 'Flow Control'),
('Which is NOT a loop in Python?', 'for', 'while', 'do-while', 'foreach', 'C', 1, 'Python', 'Flow Control'),
('What is the output? for i in range(3): print(i)', '0 1 2', '1 2 3', '0 1 2 3', '1 2', 'A', 1, 'Python', 'Flow Control'),
('Which is used for pattern matching?', 'if-else', 'switch', 'match-case', 'while', 'C', 2, 'Python', 'Flow Control'),
('What does pass do?', 'Exits function', 'Does nothing', 'Skips iteration', 'Raises error', 'B', 1, 'Python', 'Flow Control');

-- Python Functions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is a lambda function?', 'Anonymous function', 'Named function', 'Generator function', 'Async function', 'A', 1, 'Python', 'Functions'),
('What does *args allow?', 'Keyword arguments', 'Variable arguments', 'Default arguments', 'Positional arguments', 'B', 2, 'Python', 'Functions'),
('What is a decorator?', 'Function modifier', 'Variable type', 'Loop control', 'Error handler', 'A', 2, 'Python', 'Functions'),
('What does yield do?', 'Returns value', 'Pauses function', 'Exits function', 'Raises exception', 'B', 2, 'Python', 'Functions'),
('What is closure?', 'Function object', 'Nested function', 'Function with state', 'Async function', 'C', 3, 'Python', 'Functions');

-- Python File Handling
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('Which mode opens file for writing?', 'r', 'w', 'a', 'x', 'B', 1, 'Python', 'File Handling'),
('What does with statement do?', 'Opens file', 'Closes file', 'Handles context', 'Reads file', 'C', 1, 'Python', 'File Handling'),
('How to read entire file?', 'read()', 'readline()', 'readlines()', 'readall()', 'A', 1, 'Python', 'File Handling'),
('Which is binary mode?', 'rb', 'r', 'w', 'a', 'A', 1, 'Python', 'File Handling'),
('What does seek() do?', 'Reads data', 'Writes data', 'Changes position', 'Closes file', 'C', 2, 'Python', 'File Handling');

-- Python OOP
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is self?', 'Keyword', 'Instance reference', 'Class name', 'Method name', 'B', 1, 'Python', 'OOP'),
('What is inheritance?', 'Code reuse', 'Data hiding', 'Polymorphism', 'Encapsulation', 'A', 1, 'Python', 'OOP'),
('What is polymorphism?', 'Many forms', 'Data hiding', 'Inheritance', 'Encapsulation', 'A', 1, 'Python', 'OOP'),
('What is __init__?', 'Constructor', 'Destructor', 'Initializer', 'Method', 'C', 2, 'Python', 'OOP'),
('What is @classmethod?', 'Instance method', 'Class method', 'Static method', 'Private method', 'B', 2, 'Python', 'OOP');

-- Python Advanced
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is GIL?', 'Global Interpreter Lock', 'General Input Layer', 'Graphical Interface Library', 'Global Import Lock', 'A', 3, 'Python', 'Advanced'),
('What is metaclass?', 'Base class', 'Class of class', 'Abstract class', 'Interface class', 'B', 3, 'Python', 'Advanced'),
('What is async/await?', 'Synchronous programming', 'Asynchronous programming', 'Parallel programming', 'Thread programming', 'B', 2, 'Python', 'Advanced'),
('What is list comprehension?', 'Loop construct', 'Conditional construct', 'Concise list creation', 'Function definition', 'C', 1, 'Python', 'Advanced'),
('What is generator?', 'Iterator creator', 'List creator', 'Function creator', 'Class creator', 'A', 2, 'Python', 'Advanced');

-- Django Basics
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is Django?', 'Web framework', 'Database', 'Language', 'Editor', 'A', 1, 'Django', 'Basics'),
('What is MVT?', 'Model-View-Template', 'Model-View-Controller', 'Main-View-Template', 'Model-Variable-Template', 'A', 1, 'Django', 'Basics'),
('What is ORM?', 'Object-Relational Mapping', 'Object-Runtime Manager', 'Online Resource Manager', 'Object-Request Mapper', 'A', 1, 'Django', 'Basics'),
('What is middleware?', 'Request processor', 'Template engine', 'Database layer', 'URL router', 'A', 2, 'Django', 'Basics'),
('What is Django admin?', 'Management interface', 'User interface', 'Database interface', 'Template interface', 'A', 1, 'Django', 'Basics');

-- Django Advanced
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What are class-based views?', 'View classes', 'Function views', 'Template views', 'Model views', 'A', 2, 'Django', 'Advanced'),
('What is Django REST framework?', 'API framework', 'Template framework', 'Database framework', 'Testing framework', 'A', 2, 'Django', 'Advanced'),
('What is signals?', 'Event system', 'URL system', 'Template system', 'Database system', 'A', 3, 'Django', 'Advanced'),
('What is migration?', 'Database schema changes', 'Code deployment', 'User migration', 'Data transfer', 'A', 2, 'Django', 'Advanced'),
('What is Django channels?', 'Websockets support', 'Email support', 'Cache support', 'Storage support', 'A', 3, 'Django', 'Advanced');

-- Docker Basics
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is Docker?', 'Container platform', 'Virtual machine', 'Programming language', 'Database', 'A', 1, 'Docker', 'Basics'),
('What is an image?', 'Template for containers', 'Running container', 'Storage volume', 'Network', 'A', 1, 'Docker', 'Basics'),
('What is a container?', 'Running instance', 'Image template', 'Network bridge', 'Storage unit', 'A', 1, 'Docker', 'Basics'),
('What is Dockerfile?', 'Image definition', 'Container config', 'Network config', 'Volume config', 'A', 1, 'Docker', 'Basics'),
('What is docker-compose?', 'Multi-container tool', 'Single container tool', 'Image builder', 'Network manager', 'A', 1, 'Docker', 'Basics');

-- Docker Advanced
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is Docker swarm?', 'Orchestration tool', 'Networking tool', 'Storage tool', 'Monitoring tool', 'A', 2, 'Docker', 'Advanced'),
('What is a Docker volume?', 'Persistent storage', 'Temporary storage', 'Network storage', 'Memory storage', 'A', 2, 'Docker', 'Advanced'),
('What is Docker network?', 'Container networking', 'Host networking', 'Internet networking', 'VPN networking', 'A', 2, 'Docker', 'Advanced'),
('What is .dockerignore?', 'File exclusion', 'Image building', 'Container running', 'Networking', 'A', 2, 'Docker', 'Advanced'),
('What is multi-stage build?', 'Optimized builds', 'Simple builds', 'Debug builds', 'Test builds', 'A', 3, 'Docker', 'Advanced');




-- Terraform Basics
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is the primary purpose of Terraform?', 'Application deployment', 'Infrastructure provisioning and management', 'Configuration management', 'Container orchestration', 'B', 1, 'Terraform', 'Basics'),
('What language does Terraform use for its configuration files?', 'YAML', 'JSON', 'HCL (HashiCorp Configuration Language)', 'Python', 'C', 1, 'Terraform', 'Basics'),
('Which command is used to initialize a Terraform working directory?', 'terraform plan', 'terraform apply', 'terraform init', 'terraform validate', 'C', 1, 'Terraform', 'Basics'),
('What is the file name for Terraform variable definitions?', 'variables.tf', 'terraform.tfvars', 'main.tf', 'outputs.tf', 'B', 1, 'Terraform', 'Basics'),
('Which command generates an execution plan?', 'terraform init', 'terraform plan', 'terraform apply', 'terraform destroy', 'B', 1, 'Terraform', 'Basics'),
('What is a Terraform provider?', 'A plugin to interact with an API', 'A user who runs Terraform', 'A type of resource', 'A module source', 'A', 1, 'Terraform', 'Basics'),
('Which block is used to define a managed resource?', 'variable', 'output', 'resource', 'provider', 'C', 1, 'Terraform', 'Basics'),
('What does "IaC" stand for?', 'Infrastructure as Code', 'Integration as Code', 'Interface as Code', 'Input as Code', 'A', 1, 'Terraform', 'Basics'),
('Which command applies the changes to reach the desired state?', 'terraform init', 'terraform plan', 'terraform apply', 'terraform refresh', 'C', 1, 'Terraform', 'Basics'),
('What is the purpose of the `output` block?', 'To define input variables', 'To export values for users', 'To declare providers', 'To store secret data', 'B', 1, 'Terraform', 'Basics'),
('Which file is used to ignore certain files in Terraform?', '.gitignore', '.terraformignore', '.ignore', '.tfignore', 'B', 2, 'Terraform', 'Basics'),
('What is the default name for the state file?', 'terraform.state', 'state.tf', 'terraform.tfstate', 'tf.state', 'C', 1, 'Terraform', 'Basics'),
('Which command destroys the infrastructure managed by Terraform?', 'terraform delete', 'terraform remove', 'terraform destroy', 'terraform erase', 'C', 1, 'Terraform', 'Basics'),
('What is the purpose of the `variable` block?', 'To output values', 'To define parameters', 'To declare resources', 'To configure providers', 'B', 1, 'Terraform', 'Basics'),
('Which of these is a valid data source?', 'data "aws_ami" "example"', 'source "aws_ami" "example"', 'resource "aws_ami" "example"', 'variable "aws_ami" "example"', 'A', 2, 'Terraform', 'Basics'),
('What does HCL stand for?', 'HashiCorp Command Language', 'HashiCorp Configuration Language', 'HashiCorp Control Language', 'HashiCorp Code Language', 'B', 1, 'Terraform', 'Basics'),
('Which command formats Terraform configuration files?', 'terraform fmt', 'terraform format', 'terraform lint', 'terraform tidy', 'A', 1, 'Terraform', 'Basics'),
('What is a Terraform module?', 'A single .tf file', 'A container for multiple resources', 'A provider plugin', 'A state management tool', 'B', 1, 'Terraform', 'Basics'),
('Which block is used to configure a provider?', 'resource', 'variable', 'provider', 'configure', 'C', 1, 'Terraform', 'Basics'),
('What is the main purpose of the Terraform state?', 'To store variable values', 'To map real-world resources to your configuration', 'To define output values', 'To manage provider plugins', 'B', 2, 'Terraform', 'Basics');

-- Ansible Basics
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is Ansible primarily used for?', 'Infrastructure Provisioning', 'Configuration Management', 'Container Runtime', 'Version Control', 'B', 1, 'Ansible', 'Basics'),
('Which language are Ansible playbooks written in?', 'Python', 'HCL', 'YAML', 'JSON', 'C', 1, 'Ansible', 'Basics'),
('What is the name of the Ansible configuration file?', 'ansible.cfg', 'ansible.conf', 'config.ansible', 'settings.yml', 'A', 1, 'Ansible', 'Basics'),
('Which command is used to run an Ansible playbook?', 'ansible run playbook.yml', 'ansible-playbook playbook.yml', 'ansible-execute playbook.yml', 'ansible apply playbook.yml', 'B', 1, 'Ansible', 'Basics'),
('What is an Ansible module?', 'A reusable playbook', 'A standalone script that Ansible executes', 'A configuration file', 'An inventory group', 'B', 1, 'Ansible', 'Basics'),
('Which file defines the hosts and groups of hosts that Ansible manages?', 'playbook.yml', 'ansible.cfg', 'inventory', 'vars.yml', 'C', 1, 'Ansible', 'Basics'),
('What is an ad-hoc command in Ansible?', 'A complex playbook', 'A quick one-line task execution', 'A module name', 'A configuration setting', 'B', 1, 'Ansible', 'Basics'),
('Which module is used to copy files to remote hosts?', 'file', 'template', 'copy', 'transfer', 'C', 1, 'Ansible', 'Basics'),
('What is the default inventory file?', '/etc/ansible/hosts', '/etc/ansible/inventory', '~/ansible/hosts', '/etc/hosts', 'A', 2, 'Ansible', 'Basics'),
('Which keyword defines the list of tasks in a playbook?', 'functions', 'procedures', 'tasks', 'steps', 'C', 1, 'Ansible', 'Basics'),
('How does Ansible primarily communicate with managed nodes?', 'HTTP', 'SSH', 'SMTP', 'gRPC', 'B', 1, 'Ansible', 'Basics'),
('What is a "play" in an Ansible playbook?', 'A single task', 'A variable', 'A set of tasks mapped to a group of hosts', 'A module', 'C', 1, 'Ansible', 'Basics'),
('Which module is used to install packages?', 'install', 'apt', 'package', 'yum', 'C', 2, 'Ansible', 'Basics'),
('What is an Ansible role?', 'A user permission', 'A pre-defined way for organizing playbooks and files', 'A type of variable', 'A connection method', 'B', 2, 'Ansible', 'Basics'),
('Which command tests the syntax of a playbook?', 'ansible-playbook --check', 'ansible-playbook --syntax-check', 'ansible-lint', 'ansible --validate', 'B', 1, 'Ansible', 'Basics'),
('What is the purpose of the "gather_facts" option in a play?', 'To collect data about the remote system', 'To install required packages', 'To group hosts', 'To define variables', 'A', 2, 'Ansible', 'Basics'),
('Which directive is used to run a task as a privileged user?', 'sudo: yes', 'become: yes', 'privilege: yes', 'root: yes', 'B', 1, 'Ansible', 'Basics'),
('What is the "handler" keyword used for?', 'To define error conditions', 'To trigger tasks on change notifications', 'To handle user input', 'To manage connections', 'B', 2, 'Ansible', 'Basics'),
('Which variable type has the highest precedence?', 'role defaults', 'play variables', 'extra variables (-e)', 'inventory variables', 'C', 3, 'Ansible', 'Basics'),
('What is the ansible.builtin collection?', 'A list of managed hosts', 'A set of core modules shipped with Ansible', 'A group of variables', 'A type of playbook', 'B', 2, 'Ansible', 'Basics');

-- Kubernetes Basics
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is Kubernetes?', 'A container runtime', 'A configuration management tool', 'A container orchestration platform', 'A virtualization technology', 'C', 1, 'Kubernetes', 'Basics'),
('What is the smallest deployable unit in Kubernetes?', 'Docker container', 'Service', 'Pod', 'Node', 'C', 1, 'Kubernetes', 'Basics'),
('Which command is used to create a resource from a YAML file?', 'kubectl apply -f file.yaml', 'kubectl create file.yaml', 'kubectl run -f file.yaml', 'kubectl deploy file.yaml', 'A', 1, 'Kubernetes', 'Basics'),
('What is a Kubernetes Node?', 'A worker machine in Kubernetes', 'A networking component', 'A type of service', 'A configuration file', 'A', 1, 'Kubernetes', 'Basics'),
('Which object provides a stable IP address and DNS name for a set of Pods?', 'Ingress', 'Deployment', 'Service', 'ConfigMap', 'C', 1, 'Kubernetes', 'Basics'),
('What is the purpose of a Deployment?', 'To store configuration data', 'To manage the lifecycle of Pods and ReplicaSets', 'To expose a network service', 'To provide persistent storage', 'B', 1, 'Kubernetes', 'Basics'),
('Where is the cluster state and configuration stored?', 'In the master node''s memory', 'In a Pod', 'In etcd', 'In a ConfigMap', 'C', 2, 'Kubernetes', 'Basics'),
('Which command lists all Pods in all namespaces?', 'kubectl get pods', 'kubectl get pods --all', 'kubectl get pods -A', 'kubectl list pods', 'C', 1, 'Kubernetes', 'Basics'),
('What is a Namespace used for?', 'To provide isolated networks', 'To create virtual clusters within a physical cluster', 'To store secrets', 'To define resource quotas', 'B', 1, 'Kubernetes', 'Basics'),
('Which object is used to store non-confidential configuration data?', 'Secret', 'ConfigMap', 'Volume', 'Environment', 'B', 1, 'Kubernetes', 'Basics'),
('What is the role of the Scheduler?', 'To assign Pods to Nodes', 'To manage cluster state', 'To expose services', 'To handle API requests', 'A', 2, 'Kubernetes', 'Basics'),
('Which object manages a set of identical Pods?', 'Service', 'ReplicaSet', 'StatefulSet', 'Deployment', 'B', 2, 'Kubernetes', 'Basics'),
('What is a DaemonSet?', 'A set of Pods that run on every Node', 'A special type of Service', 'A tool for debugging', 'A cluster storage solution', 'A', 2, 'Kubernetes', 'Basics'),
('Which command is used to see the logs of a Pod?', 'kubectl logs <pod-name>', 'kubectl get logs <pod-name>', 'kubectl view logs <pod-name>', 'kubectl describe logs <pod-name>', 'A', 1, 'Kubernetes', 'Basics'),
('What is the default namespace?', 'default', 'system', 'master', 'kube-system', 'A', 1, 'Kubernetes', 'Basics'),
('Which object is used to manage stateful applications?', 'Deployment', 'ReplicaSet', 'StatefulSet', 'DaemonSet', 'C', 2, 'Kubernetes', 'Basics'),
('What is the purpose of a PersistentVolume (PV)?', 'To provide temporary storage to a Pod', 'To store cluster configuration', 'To represent a piece of networked storage in the cluster', 'To define a network policy', 'C', 2, 'Kubernetes', 'Basics'),
('Which API object is used to scale a Deployment?', 'Scale', 'Replica', 'HorizontalPodAutoscaler', 'Size', 'C', 2, 'Kubernetes', 'Basics'),
('What is an Ingress?', 'An API object that manages external access to services', 'A type of Pod', 'A cluster node', 'A storage class', 'A', 2, 'Kubernetes', 'Basics'),
('Which command provides an interactive shell to a running Pod?', 'kubectl shell <pod-name>', 'kubectl attach <pod-name>', 'kubectl exec -it <pod-name> -- /bin/bash', 'kubectl run -it <pod-name>', 'C', 1, 'Kubernetes', 'Basics');

-- Python Basics - Adding 15 more questions to make 20 total
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('Which of these is NOT a built-in data type?', 'list', 'tuple', 'array', 'dict', 'C', 1, 'Python', 'Basics'),
('What is the result of 3 * ''hello''?', 'hellohellohello', 'hello*3', 'TypeError', 'hello hello hello', 'A', 1, 'Python', 'Basics'),
('How do you start a comment in Python?', '//', '#', '/*', '--', 'B', 1, 'Python', 'Basics'),
('What does the type() function return?', 'The value of the object', 'The class of the object', 'The memory address', 'The size of the object', 'B', 1, 'Python', 'Basics'),
('Which method is used to get the length of a list?', 'length()', 'size()', 'len()', 'count()', 'C', 1, 'Python', 'Basics'),
('What is the output of bool(0)?', 'True', 'False', '0', 'None', 'B', 1, 'Python', 'Basics'),
('Which operator is used for integer division?', '/', '//', '%', 'div', 'B', 1, 'Python', 'Basics'),
('How do you create an empty dictionary?', '{}', '[]', 'dict()', 'Both A and C', 'D', 1, 'Python', 'Basics'),
('What is the result of "hello"[1]?', 'h', 'e', 'l', 'o', 'B', 1, 'Python', 'Basics'),
('Which function converts a string to an integer?', 'str()', 'int()', 'float()', 'number()', 'B', 1, 'Python', 'Basics'),
('What does the % operator do?', 'Percentage', 'Modulus/remainder', 'Division', 'Multiplication', 'B', 1, 'Python', 'Basics'),
('How do you check if a key exists in a dictionary?', 'key in dict', 'dict.has_key()', 'dict.contains()', 'dict.exists()', 'A', 2, 'Python', 'Basics'),
('What is the result of round(3.75)?', '3', '3.7', '4', '3.8', 'C', 2, 'Python', 'Basics'),
('Which is immutable?', 'list', 'dict', 'set', 'string', 'D', 2, 'Python', 'Basics'),
('What does the ord() function do?', 'Returns the order of a list', 'Returns ASCII value of a character', 'Organizes data', 'Returns ordinal number', 'B', 2, 'Python', 'Basics');

-- Python Flow Control - Adding 15 more questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What does continue do in a loop?', 'Exits the loop', 'Skips current iteration', 'Restarts the loop', 'Pauses the loop', 'B', 1, 'Python', 'Flow Control'),
('Which is used for conditional execution?', 'for', 'while', 'if', 'try', 'C', 1, 'Python', 'Flow Control'),
('What is the output? x = 5; if x > 3: print("A") else: print("B")', 'A', 'B', 'AB', 'Error', 'A', 1, 'Python', 'Flow Control'),
('How many times will this loop run? for i in range(5):', '4', '5', '6', 'Infinite', 'B', 1, 'Python', 'Flow Control'),
('What does the else clause do with a loop?', 'Runs if loop completes normally', 'Runs if loop breaks', 'Always runs', 'Never runs', 'A', 2, 'Python', 'Flow Control'),
('Which is NOT a valid conditional statement?', 'if x > y:', 'elif x == y:', 'else if x < y:', 'else:', 'C', 1, 'Python', 'Flow Control'),
('What is the purpose of the pass statement?', 'To exit a function', 'To skip iteration', 'As a placeholder', 'To raise an error', 'C', 1, 'Python', 'Flow Control'),
('What does range(2, 6) generate?', '[2, 3, 4, 5]', '[2, 3, 4, 5, 6]', '[1, 2, 3, 4, 5]', '[0, 1, 2, 3, 4, 5]', 'A', 1, 'Python', 'Flow Control'),
('Which loop is guaranteed to run at least once?', 'for', 'while', 'do-while', 'None of the above', 'D', 2, 'Python', 'Flow Control'),
('What is the ternary operator syntax?', 'x if condition else y', 'if condition then x else y', 'condition ? x : y', 'x when condition else y', 'A', 2, 'Python', 'Flow Control'),
('How to iterate over both index and value in a list?', 'for i in list:', 'for i, value in list:', 'for i, value in enumerate(list):', 'for index, value in list.items():', 'C', 2, 'Python', 'Flow Control'),
('What does the zip() function do?', 'Compresses files', 'Combines iterables', 'Creates loops', 'Sorts data', 'B', 2, 'Python', 'Flow Control'),
('Which statement is used for exception handling?', 'try-catch', 'try-except', 'error-handle', 'catch-error', 'B', 1, 'Python', 'Flow Control'),
('What does finally do in try-except?', 'Runs only if no exception', 'Runs only if exception', 'Always runs', 'Never runs', 'C', 2, 'Python', 'Flow Control'),
('What is the purpose of the with statement?', 'Loop control', 'Context management', 'Conditional execution', 'Function definition', 'B', 2, 'Python', 'Flow Control');

-- Python Functions - Adding 15 more questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('How do you define a function?', 'function my_func():', 'def my_func():', 'define my_func():', 'func my_func():', 'B', 1, 'Python', 'Functions'),
('What is a docstring?', 'A string document', 'Function documentation', 'A type of comment', 'A variable', 'B', 1, 'Python', 'Functions'),
('What does return None do?', 'Returns 0', 'Returns empty string', 'Returns nothing', 'Returns False', 'C', 1, 'Python', 'Functions'),
('What are **kwargs?', 'Keyword arguments', 'Positional arguments', 'Default arguments', 'Variable arguments', 'A', 2, 'Python', 'Functions'),
('What is a recursive function?', 'A function that calls itself', 'A function that returns quickly', 'A function with many parameters', 'A built-in function', 'A', 2, 'Python', 'Functions'),
('What is the scope of a variable defined inside a function?', 'Global', 'Local', 'Module', 'Class', 'B', 1, 'Python', 'Functions'),
('How to access a global variable inside a function?', 'global keyword', 'globals()', 'It''s accessible directly', 'Cannot access', 'A', 2, 'Python', 'Functions'),
('What is a generator function?', 'A function that generates numbers', 'A function with yield statement', 'A function that creates objects', 'A built-in function', 'B', 2, 'Python', 'Functions'),
('What does the map() function do?', 'Creates a dictionary', 'Applies function to iterable', 'Creates a map object', 'Both B and C', 'D', 2, 'Python', 'Functions'),
('What is filter() used for?', 'To filter lists', 'To remove elements', 'To apply conditional filtering', 'All of the above', 'C', 2, 'Python', 'Functions'),
('What is a pure function?', 'A function without side effects', 'A function that only uses pure Python', 'A function without parameters', 'A mathematical function', 'A', 3, 'Python', 'Functions'),
('What is function composition?', 'Combining functions', 'Writing function documentation', 'Creating function objects', 'Debugging functions', 'A', 3, 'Python', 'Functions'),
('What does functools.partial do?', 'Creates partial functions', 'Splits functions', 'Optimizes functions', 'Decorates functions', 'A', 3, 'Python', 'Functions'),
('What is a higher-order function?', 'A function that takes other functions as arguments', 'A complex function', 'A function that returns functions', 'Both A and C', 'D', 3, 'Python', 'Functions'),
('What is the purpose of __name__ == "__main__"?', 'To define main function', 'To make script executable', 'To check if file is run directly', 'To create entry point', 'C', 2, 'Python', 'Functions');

-- Python File Handling - Adding 15 more questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('Which mode opens file for appending?', 'r', 'w', 'a', 'x', 'C', 1, 'Python', 'File Handling'),
('What does the ''x'' mode do?', 'Reads file', 'Writes file', 'Creates file, error if exists', 'Appends to file', 'C', 2, 'Python', 'File Handling'),
('How to open a file in read and write mode?', 'r+', 'w+', 'a+', 'All of the above', 'D', 2, 'Python', 'File Handling'),
('What does readline() return at EOF?', 'Empty string', 'None', 'False', 'Error', 'A', 2, 'Python', 'File Handling'),
('How to write multiple lines to a file?', 'write()', 'writeline()', 'writelines()', 'writeall()', 'C', 2, 'Python', 'File Handling'),
('What is the default encoding in open()?', 'utf-8', 'ascii', 'Platform dependent', 'None', 'C', 3, 'Python', 'File Handling'),
('What does the tell() method do?', 'Returns current file position', 'Checks if file exists', 'Closes file', 'Reads file', 'A', 2, 'Python', 'File Handling'),
('How to check if a file exists?', 'os.path.exists()', 'file.exists()', 'path.exists()', 'exists()', 'A', 2, 'Python', 'File Handling'),
('What is the purpose of the ''b'' in file mode?', 'Backup mode', 'Binary mode', 'Buffer mode', 'Byte mode', 'B', 1, 'Python', 'File Handling'),
('How to delete a file?', 'os.remove()', 'file.delete()', 'delete()', 'remove()', 'A', 2, 'Python', 'File Handling'),
('What is a file object?', 'The file itself', 'A reference to the file', 'A string', 'A list', 'B', 2, 'Python', 'File Handling'),
('What does flush() do?', 'Clears the file', 'Writes buffer to file', 'Closes the file', 'Reads the file', 'B', 3, 'Python', 'File Handling'),
('How to create a directory?', 'os.mkdir()', 'dir.create()', 'mkdir()', 'create.dir()', 'A', 2, 'Python', 'File Handling'),
('What is the purpose of json.load()?', 'Load JSON from file', 'Load JSON from string', 'Convert to JSON', 'Parse JSON', 'A', 2, 'Python', 'File Handling'),
('What is pickle used for?', 'Object serialization', 'File compression', 'Data parsing', 'Text processing', 'A', 2, 'Python', 'File Handling');

-- Python OOP - Adding 15 more questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is encapsulation?', 'Data hiding', 'Code reuse', 'Many forms', 'Inheritance', 'A', 2, 'Python', 'OOP'),
('What is __str__ method for?', 'String representation', 'Initialization', 'Destruction', 'Comparison', 'A', 2, 'Python', 'OOP'),
('How to create a class?', 'class MyClass:', 'def MyClass:', 'create class MyClass:', 'object MyClass:', 'A', 1, 'Python', 'OOP'),
('What is method overriding?', 'Changing method implementation in child class', 'Creating new methods', 'Hiding methods', 'Deleting methods', 'A', 2, 'Python', 'OOP'),
('What is a class variable?', 'Variable shared by all instances', 'Variable specific to instance', 'Local variable', 'Global variable', 'A', 2, 'Python', 'OOP'),
('What is the purpose of super()?', 'To call parent class methods', 'To create super classes', 'To improve performance', 'To make classes better', 'A', 2, 'Python', 'OOP'),
('What is multiple inheritance?', 'Inheriting from multiple classes', 'Having multiple child classes', 'Inheriting multiple times', 'Complex inheritance', 'A', 3, 'Python', 'OOP'),
('What is an abstract class?', 'A class that cannot be instantiated', 'A vague class', 'A base class', 'A simple class', 'A', 3, 'Python', 'OOP'),
('What is @staticmethod?', 'A method that doesn''t need self', 'A static variable', 'A class method', 'A private method', 'A', 2, 'Python', 'OOP'),
('What is name mangling?', 'Making names private', 'Changing method names', 'Hiding attributes', 'All of the above', 'C', 3, 'Python', 'OOP'),
('What is the MRO?', 'Method Resolution Order', 'Method Return Order', 'Method Reference Object', 'Module Resolution Order', 'A', 3, 'Python', 'OOP'),
('What is a property?', 'A class attribute', 'A managed attribute', 'A method', 'A variable', 'B', 3, 'Python', 'OOP'),
('What is __slots__ used for?', 'Memory optimization', 'Method organization', 'Class inheritance', 'Object creation', 'A', 3, 'Python', 'OOP'),
('What is a mixin?', 'A class providing methods to other classes', 'A mixing class', 'A complex class', 'A base class', 'A', 3, 'Python', 'OOP'),
('What is the purpose of __new__?', 'To create new instances', 'To initialize instances', 'To allocate memory', 'Both A and C', 'D', 3, 'Python', 'OOP');

-- Python Advanced - Adding 15 more questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is a context manager?', 'Manages file contexts', 'Manages resources with with statement', 'Manages variable scope', 'Manages memory', 'B', 2, 'Python', 'Advanced'),
('What are decorators with parameters?', 'Decorators that take arguments', 'Complex decorators', 'Nested decorators', 'Method decorators', 'A', 3, 'Python', 'Advanced'),
('What is the purpose of __init__.py?', 'To make directory a package', 'To initialize modules', 'To run code on import', 'All of the above', 'D', 2, 'Python', 'Advanced'),
('What is monkey patching?', 'Modifying code at runtime', 'Fixing bugs', 'Testing code', 'Debugging', 'A', 3, 'Python', 'Advanced'),
('What is a descriptor?', 'An object attribute with binding behavior', 'A file descriptor', 'A method descriptor', 'A class descriptor', 'A', 3, 'Python', 'Advanced'),
('What is the purpose of asyncio?', 'Asynchronous I/O', 'Synchronous I/O', 'Parallel processing', 'Thread management', 'A', 3, 'Python', 'Advanced'),
('What is a coroutine?', 'A special function that can pause/resume', 'A routine function', 'A coordinated function', 'A complex function', 'A', 3, 'Python', 'Advanced'),
('What is the purpose of typing module?', 'Type hints', 'Type checking', 'Type conversion', 'Type creation', 'A', 2, 'Python', 'Advanced'),
('What are dataclasses?', 'Classes for data storage', 'Auto-generated classes', 'Classes with boilerplate code', 'All of the above', 'D', 3, 'Python', 'Advanced'),
('What is the purpose of __getitem__?', 'To get items by index', 'To implement indexing', 'To access elements', 'All of the above', 'D', 3, 'Python', 'Advanced'),
('What is a metaclass''s __new__ method for?', 'To create the class object', 'To initialize the class', 'To modify class creation', 'Both A and C', 'D', 3, 'Python', 'Advanced'),
('What is the purpose of functools.lru_cache?', 'Memoization', 'Caching', 'Optimization', 'All of the above', 'D', 3, 'Python', 'Advanced'),
('What is a weak reference?', 'A reference that doesn''t prevent garbage collection', 'A weak pointer', 'A temporary reference', 'A fragile reference', 'A', 3, 'Python', 'Advanced'),
('What is the purpose of the array module?', 'Efficient arrays', 'Numerical arrays', 'Memory-efficient arrays', 'All of the above', 'D', 3, 'Python', 'Advanced'),
('What is the purpose of sys.settrace?', 'To set trace function', 'For debugging', 'For profiling', 'All of the above', 'D', 3, 'Python', 'Advanced');

-- Django Basics - Adding 15 more questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What command starts a Django project?', 'django startproject', 'django-admin startproject', 'python startproject', 'django createproject', 'B', 1, 'Django', 'Basics'),
('What is the purpose of manage.py?', 'Project management', 'Command-line utility', 'App management', 'All of the above', 'D', 1, 'Django', 'Basics'),
('How to create a Django app?', 'python manage.py createapp', 'python manage.py startapp', 'django createapp', 'django startapp', 'B', 1, 'Django', 'Basics'),
('What is the purpose of settings.py?', 'Project configuration', 'App configuration', 'Database configuration', 'All of the above', 'D', 1, 'Django', 'Basics'),
('What is urls.py used for?', 'URL configuration', 'URL routing', 'URL patterns', 'All of the above', 'D', 1, 'Django', 'Basics'),
('What is the purpose of models.py?', 'Database models', 'Data structure definition', 'ORM classes', 'All of the above', 'D', 1, 'Django', 'Basics'),
('How to create database tables?', 'python manage.py create_tables', 'python manage.py migrate', 'python manage.py makemigrations', 'Both B and C', 'D', 1, 'Django', 'Basics'),
('What is the purpose of views.py?', 'Business logic', 'Request handling', 'Response generation', 'All of the above', 'D', 1, 'Django', 'Basics'),
('What is a QuerySet?', 'Database query', 'Collection of objects', 'Lazy database query', 'All of the above', 'D', 2, 'Django', 'Basics'),
('What is the purpose of the shell?', 'Interactive Python', 'Database exploration', 'Testing', 'All of the above', 'D', 1, 'Django', 'Basics'),
('How to create a superuser?', 'python manage.py createsuperuser', 'python manage.py superuser', 'django createsuperuser', 'django superuser', 'A', 1, 'Django', 'Basics'),
('What is the purpose of static files?', 'CSS, JS, images', 'Templates', 'Database files', 'Python files', 'A', 1, 'Django', 'Basics'),
('What is the purpose of templates?', 'HTML rendering', 'Presentation layer', 'Dynamic content', 'All of the above', 'D', 1, 'Django', 'Basics'),
('What is the purpose of forms.py?', 'Form handling', 'Form validation', 'Form rendering', 'All of the above', 'D', 2, 'Django', 'Basics'),
('What is the purpose of the Django shell?', 'Interactive development', 'Database exploration', 'Testing code', 'All of the above', 'D', 1, 'Django', 'Basics');

-- Django Advanced - Adding 15 more questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is Django''s cache framework?', 'Caching system', 'Performance optimization', 'Template caching', 'All of the above', 'D', 2, 'Django', 'Advanced'),
('What are generic views?', 'Pre-built views', 'Class-based views', 'Common pattern views', 'All of the above', 'D', 2, 'Django', 'Advanced'),
('What is the purpose of middleware?', 'Request/response processing', 'Authentication', 'Security', 'All of the above', 'D', 2, 'Django', 'Advanced'),
('What is Django testing framework?', 'Automated testing', 'Test cases', 'Test runners', 'All of the above', 'D', 2, 'Django', 'Advanced'),
('What is the purpose of contenttypes?', 'Generic relationships', 'Content types', 'Model relationships', 'All of the above', 'D', 3, 'Django', 'Advanced'),
('What is Django''s internationalization?', 'Multi-language support', 'Localization', 'Translation', 'All of the above', 'D', 2, 'Django', 'Advanced'),
('What is the purpose of select_related?', 'SQL JOIN optimization', 'Foreign key optimization', 'One-to-one optimization', 'All of the above', 'D', 3, 'Django', 'Advanced'),
('What is prefetch_related used for?', 'Many-to-many optimization', 'Reverse foreign key', 'Performance optimization', 'All of the above', 'D', 3, 'Django', 'Advanced'),
('What are Django signals?', 'Event system', 'Decoupled applications', 'Notification system', 'All of the above', 'D', 3, 'Django', 'Advanced'),
('What is the purpose of custom managers?', 'Custom QuerySets', 'Business logic encapsulation', 'Model methods', 'All of the above', 'D', 3, 'Django', 'Advanced'),
('What is Django''s security features?', 'CSRF protection', 'XSS protection', 'SQL injection protection', 'All of the above', 'D', 2, 'Django', 'Advanced'),
('What is the purpose of transaction.atomic?', 'Database transactions', 'Atomic operations', 'Data integrity', 'All of the above', 'D', 3, 'Django', 'Advanced'),
('What are Django templates inheritance?', 'DRY templates', 'Base templates', 'Template reuse', 'All of the above', 'D', 2, 'Django', 'Advanced'),
('What is the purpose of custom template tags?', 'Custom template logic', 'Reusable components', 'Complex rendering', 'All of the above', 'D', 3, 'Django', 'Advanced'),
('What is Django''s logging system?', 'Application logging', 'Debugging', 'Monitoring', 'All of the above', 'D', 2, 'Django', 'Advanced');

-- Docker Basics - Adding 15 more questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is the difference between Docker and VM?', 'Docker uses containerization', 'Docker shares OS kernel', 'Docker is lighter', 'All of the above', 'D', 1, 'Docker', 'Basics'),
('How to build a Docker image?', 'docker build', 'docker create', 'docker image build', 'docker make', 'A', 1, 'Docker', 'Basics'),
('How to run a Docker container?', 'docker run', 'docker start', 'docker execute', 'docker create', 'A', 1, 'Docker', 'Basics'),
('What is the purpose of EXPOSE in Dockerfile?', 'Documents ports', 'Publishes ports', 'Opens firewall', 'Configures network', 'A', 2, 'Docker', 'Basics'),
('How to list running containers?', 'docker ps', 'docker list', 'docker containers', 'docker show', 'A', 1, 'Docker', 'Basics'),
('How to stop a container?', 'docker stop', 'docker kill', 'docker halt', 'Both A and B', 'D', 1, 'Docker', 'Basics'),
('What is the purpose of CMD in Dockerfile?', 'Default command to run', 'Build command', 'Configuration command', 'Setup command', 'A', 2, 'Docker', 'Basics'),
('What is the purpose of ENTRYPOINT?', 'Main executable', 'Default command', 'Container entry', 'All of the above', 'D', 2, 'Docker', 'Basics'),
('How to remove a container?', 'docker rm', 'docker delete', 'docker remove', 'docker del', 'A', 1, 'Docker', 'Basics'),
('How to remove an image?', 'docker rmi', 'docker image rm', 'docker delete', 'Both A and B', 'D', 1, 'Docker', 'Basics'),
('What is a Docker registry?', 'Image storage', 'Docker Hub', 'Image repository', 'All of the above', 'D', 1, 'Docker', 'Basics'),
('How to push an image to registry?', 'docker push', 'docker upload', 'docker send', 'docker publish', 'A', 1, 'Docker', 'Basics'),
('How to pull an image?', 'docker pull', 'docker download', 'docker get', 'docker fetch', 'A', 1, 'Docker', 'Basics'),
('What is the purpose of .dockerignore?', 'Exclude files from build', 'Ignore commands', 'Skip steps', 'Optimize build', 'A', 2, 'Docker', 'Basics'),
('What is the purpose of WORKDIR in Dockerfile?', 'Set working directory', 'Create directory', 'Change directory', 'All of the above', 'D', 2, 'Docker', 'Basics');

-- Docker Advanced - Adding 15 more questions
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, category, subcategory) VALUES
('What is Docker networking?', 'Container communication', 'Network isolation', 'Port mapping', 'All of the above', 'D', 2, 'Docker', 'Advanced'),
('What are Docker volumes?', 'Persistent storage', 'Data persistence', 'Shared storage', 'All of the above', 'D', 2, 'Docker', 'Advanced'),
('What is Docker Compose?', 'Multi-container applications', 'Orchestration tool', 'Service definition', 'All of the above', 'D', 2, 'Docker', 'Advanced'),
('What is the purpose of docker-compose.yml?', 'Service configuration', 'Container definition', 'Orchestration setup', 'All of the above', 'D', 2, 'Docker', 'Advanced'),
('What is Docker Swarm?', 'Native clustering', 'Orchestration', 'Container management', 'All of the above', 'D', 3, 'Docker', 'Advanced'),
('What are Docker secrets?', 'Secure configuration', 'Sensitive data', 'Encrypted data', 'All of the above', 'D', 3, 'Docker', 'Advanced'),
('What is the purpose of healthchecks?', 'Container health monitoring', 'Service availability', 'Auto-recovery', 'All of the above', 'D', 3, 'Docker', 'Advanced'),
('What are Docker labels?', 'Metadata', 'Key-value pairs', 'Organization', 'All of the above', 'D', 2, 'Docker', 'Advanced'),
('What is the purpose of docker system prune?', 'Cleanup unused data', 'Remove containers', 'Remove images', 'All of the above', 'D', 2, 'Docker', 'Advanced'),
('What are multi-stage builds?', 'Optimized images', 'Build separation', 'Smaller images', 'All of the above', 'D', 3, 'Docker', 'Advanced'),
('What is the purpose of docker exec?', 'Run command in container', 'Execute process', 'Debug container', 'All of the above', 'D', 2, 'Docker', 'Advanced'),
('What are Docker networks drivers?', 'Bridge', 'Host', 'Overlay', 'All of the above', 'D', 3, 'Docker', 'Advanced'),
('What is the purpose of docker logs?', 'Container logs', 'Debugging', 'Monitoring', 'All of the above', 'D', 2, 'Docker', 'Advanced'),
('What are Docker configs?', 'Configuration files', 'Non-sensitive data', 'Swarm configs', 'All of the above', 'D', 3, 'Docker', 'Advanced'),
('What is the purpose of resource constraints?', 'Memory limits', 'CPU limits', 'Performance control', 'All of the above', 'D', 3, 'Docker', 'Advanced');