class Environment {
  final String name;
  final String nutroboBaseUrl;

  const Environment({
    required this.name,
    required this.nutroboBaseUrl
  });
}

class Environments {
  final List<Environment> environments;

  Environments({
    required this.environments,
  });

  Environment get(String? name) {
    return environments.firstWhere(
        (env) => env.name == name,
        orElse: () => environments.first
    );
  }

}