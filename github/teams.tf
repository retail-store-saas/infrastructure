resource "github_team" "titans" {
  name        = "titans"
  privacy     = "closed"
  description = "Frontend developers"
}

resource "github_team" "velocity" {
  name        = "velocity"
  privacy     = "closed"
  description = "Cart service developers"
}

resource "github_team" "hive" {
  name        = "hive"
  privacy     = "closed"
  description = "Product catalog service developers"
}

resource "github_team" "elite" {
  name        = "elite"
  privacy     = "closed"
  description = "Currency service developers"
}

resource "github_team" "armada" {
  name        = "armada"
  privacy     = "closed"
  description = "Payment service developers"
}

resource "github_team" "aces" {
  name        = "aces"
  privacy     = "closed"
  description = "Shipping service developers"
}

resource "github_team" "united" {
  name        = "united"
  privacy     = "closed"
  description = "Email service developers"
}

resource "github_team" "renegades" {
  name        = "renegades"
  privacy     = "closed"
  description = "Checkout service developers"
}

resource "github_team" "outliers" {
  name        = "outliers"
  privacy     = "closed"
  description = "Recommendation service developers"
}

resource "github_team" "outlaws" {
  name        = "outlaws"
  privacy     = "closed"
  description = "Ad service developers"
}

resource "github_team" "defenders" {
  name        = "defenders"
  privacy     = "closed"
  description = "Security team"
}

resource "github_team" "samurais" {
  name        = "samurais"
  privacy     = "closed"
  description = "Infrastructure developers"
}

resource "github_team" "auditors" {
  name        = "auditors"
  privacy     = "closed"
  description = "Auditors"
}

resource "github_team_membership" "Arvi3d_auditor" {
  team_id  = github_team.auditors.id
  username = "Arvi3d"
  role     = "maintainer"
}

resource "github_team_membership" "ebhardjan_auditor" {
  team_id  = github_team.auditors.id
  username = "ebhardjan"
  role     = "maintainer"
}

resource "github_team_membership" "tch1bo_auditor" {
  team_id  = github_team.auditors.id
  username = "tch1bo"
  role     = "maintainer"
}

resource "github_team_membership" "vraychev_auditor" {
  team_id  = github_team.auditors.id
  username = "vraychev"
  role     = "member"
}

resource "github_team_membership" "giofunchal_auditor" {
  team_id  = github_team.auditors.id
  username = "giofunchal"
  role     = "maintainer"
}

resource "github_team_membership" "sny_retail_store_demo_ro_auditor" {
  team_id  = github_team.auditors.id
  username = "retail-store-saas-ro"
  role     = "maintainer"
}

resource "github_team_membership" "amelia_pekler_snyk_auditor" {
  team_id  = github_team.auditors.id
  username = "amelia-peklar-snyk"
  role     = "member"
}


resource "github_team_membership" "ricardo_snyk_auditor" {
  team_id  = github_team.auditors.id
  username = "ricardosnyk"
  role     = "member"
}

locals {
  auditors = toset([
    "andrewsouthard1",
    "anthonyseto ",
    "schottsfired",
    "dylansnyk",
    "jhinz1",
    "morgansnyk",
    "shawna-alpdemir",
    "snyk-schmidtty",
    "aboulmagSnyk",
    "sjmaple"
  ])
}

resource "github_team_membership" "snyk_auditor" {
  for_each = local.auditors
  team_id  = github_team.auditors.id
  username = each.key
  role     = "member"
}


resource "github_team" "admins" {
  name        = "admins"
  privacy     = "closed"
  description = "Organization administrators"
}

resource "github_team_membership" "p0tr3c_admin" {
  team_id  = github_team.admins.id
  username = "p0tr3c"
  role     = "maintainer"
}

resource "github_team_membership" "cmars_admin" {
  team_id = github_team.admins.id
  role    = "maintainer"

  username = "cmars"
}

resource "github_team_membership" "benbarnett_admin" {
  team_id = github_team.admins.id
  role    = "maintainer"

  username = "benbarnett"
}

resource "github_team_membership" "nvin7" {
  team_id = github_team.admins.id
  role    = "maintainer"

  username = "nvin7"
}

resource "github_team_membership" "yeforriak_admin" {
  team_id = github_team.admins.id
  role    = "maintainer"

  username = "yeforriak"
}

resource "github_team_membership" "benlaplanche_admin" {
  team_id = github_team.admins.id
  role    = "maintainer"

  username = "benlaplanche"
}

resource "github_team_membership" "anvilalta_admin" {
  team_id = github_team.admins.id
  role    = "maintainer"

  username = "anvilalta"
}

resource "github_team_membership" "boris_snyk" {
  team_id = github_team.admins.id
  role    = "maintainer"

  username = "boris-snyk"
}
