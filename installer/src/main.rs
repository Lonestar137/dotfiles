use serde_yaml::Value;
use std::{
    collections::HashMap,
    env::{self, VarsOs},
    fs::{read_dir, File},
    io::Read,
    sync::Arc,
};

struct InstallerState {
    load_env_vars: bool,
    packages: Vec<String>,
    symlinks: Vec<String>,
}

fn read_yml(yml_file: &str) -> HashMap<String, Value> {
    let mut file = File::open(&yml_file).expect("Failed to open yaml file.");

    let mut contents = String::new();
    file.read_to_string(&mut contents)
        .expect("Failed to read yaml file.");

    return serde_yaml::from_str(&contents).expect("Failed to parse YAML");
}

fn parse_package_index(map: HashMap<String, Value>) {}

fn main() {
    /// CLI args
    let base_path = "..";
    let env_vars: VarsOs = env::vars_os();
    let env_map: HashMap<String, String> = HashMap::new();

    let config_path = format!("{}/config", &base_path);
    let dirs = read_dir(&config_path).unwrap().filter(|x| x.is_ok());
    dirs.for_each(|x| println!("{:?}", &x.unwrap()));

    let yml_file = |y: &str| format!("{}/{}", &base_path, y);

    let build_file = yml_file("build.yml");
    let index_file = yml_file("index.yml");

    let package_mapping = read_yml(&index_file);
    let build_file = read_yml(&build_file);

    for (key, value) in &build_file {
        println!("{:?}", key);
        match key.as_str() {
            "load_env_vars" => {}
            "vars" => {}
            "install" => {}
            "configs" => {}
            _ => {
                eprintln!("Got an unexpected key!");
            }
        }
    }

    // println!("{:?}", &build_file);

    // read build yml and reference package mapping
}
