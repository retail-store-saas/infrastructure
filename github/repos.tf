resource "github_repository" "infrastructure" {
  name        = "infrastructure"
  description = "Cloud infrastructure manifests"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true

}

resource "github_team_repository" "infrastructure_maintain" {
  team_id    = github_team.samurais.id
  repository = github_repository.infrastructure.name
  permission = "maintain"
}

resource "github_team_repository" "infrastructure_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.infrastructure.name
  permission = "admin"
}

resource "github_team_repository" "infrastructure_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.infrastructure.name
  permission = "pull"
}



resource "github_repository" "store" {
  name        = "store"
  description = "Store deployment orchestration"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true

}

resource "github_team_repository" "store_maintain" {
  team_id    = github_team.samurais.id
  repository = github_repository.store.name
  permission = "maintain"
}

resource "github_team_repository" "store_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.store.name
  permission = "admin"
}


resource "github_team_repository" "store_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.store.name
  permission = "pull"
}


resource "github_repository" "frontend" {
  name        = "frontend"
  description = "Frontend service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true

}


resource "github_team_repository" "frontend_maintain" {
  team_id    = github_team.titans.id
  repository = github_repository.frontend.name
  permission = "maintain"
}

resource "github_team_repository" "frontend_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.frontend.name
  permission = "admin"
}

resource "github_team_repository" "frontend_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.frontend.name
  permission = "pull"
}


resource "github_repository" "cartservice" {
  name        = "cart"
  description = "Cart service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true

}


resource "github_team_repository" "cart_maintain" {
  team_id    = github_team.velocity.id
  repository = github_repository.cartservice.name
  permission = "maintain"
}

resource "github_team_repository" "cart_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.cartservice.name
  permission = "admin"
}

resource "github_team_repository" "cart_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.cartservice.name
  permission = "pull"
}



resource "github_repository" "productcatalogservice" {
  name        = "productcatalog"
  description = "Product catalog service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true
}


resource "github_team_repository" "productcatalog_maintain" {
  team_id    = github_team.hive.id
  repository = github_repository.productcatalogservice.name
  permission = "maintain"
}

resource "github_team_repository" "productcatalog_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.productcatalogservice.name
  permission = "admin"
}


resource "github_team_repository" "productcatalog_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.productcatalogservice.name
  permission = "pull"
}


resource "github_repository" "adservice" {
  name        = "ad"
  description = "Ad service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true
}


resource "github_team_repository" "ad_maintain" {
  team_id    = github_team.outlaws.id
  repository = github_repository.adservice.name
  permission = "maintain"
}

resource "github_team_repository" "ad_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.adservice.name
  permission = "admin"
}

resource "github_team_repository" "ad_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.adservice.name
  permission = "pull"
}



resource "github_repository" "checkoutservice" {
  name        = "checkout"
  description = "Checkout service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true
}

resource "github_team_repository" "checkout_maintain" {
  team_id    = github_team.renegades.id
  repository = github_repository.checkoutservice.name
  permission = "maintain"
}

resource "github_team_repository" "checkout_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.checkoutservice.name
  permission = "admin"
}


resource "github_team_repository" "checkout_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.checkoutservice.name
  permission = "pull"
}




resource "github_repository" "currencyservice" {
  name        = "currency"
  description = "Currency service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true
}


resource "github_team_repository" "currency_maintain" {
  team_id    = github_team.elite.id
  repository = github_repository.currencyservice.name
  permission = "maintain"
}

resource "github_team_repository" "currency_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.currencyservice.name
  permission = "admin"
}

resource "github_team_repository" "currency_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.currencyservice.name
  permission = "pull"
}


resource "github_repository" "emailservice" {
  name        = "email"
  description = "Email service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true
}


resource "github_team_repository" "eamil_maintain" {
  team_id    = github_team.united.id
  repository = github_repository.emailservice.name
  permission = "maintain"
}

resource "github_team_repository" "united_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.emailservice.name
  permission = "admin"
}


resource "github_team_repository" "email_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.emailservice.name
  permission = "pull"
}




resource "github_repository" "paymentservice" {
  name        = "payment"
  description = "Payment service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true
}


resource "github_team_repository" "payment_maintain" {
  team_id    = github_team.armada.id
  repository = github_repository.paymentservice.name
  permission = "maintain"
}

resource "github_team_repository" "payment_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.paymentservice.name
  permission = "admin"
}


resource "github_team_repository" "payment_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.paymentservice.name
  permission = "pull"
}



resource "github_repository" "recommendationservice" {
  name        = "recommendation"
  description = "Recommendation service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true
}


resource "github_team_repository" "recommendation_maintain" {
  team_id    = github_team.outliers.id
  repository = github_repository.recommendationservice.name
  permission = "maintain"
}

resource "github_team_repository" "recommendation_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.recommendationservice.name
  permission = "admin"
}

resource "github_team_repository" "recommendation_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.recommendationservice.name
  permission = "pull"
}

resource "github_repository" "shippingservice" {
  name        = "shipping"
  description = "Shipping service"

  visibility = "private"

  license_template = "apache-2.0"

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true
}

resource "github_team_repository" "shipping_maintain" {
  team_id    = github_team.aces.id
  repository = github_repository.shippingservice.name
  permission = "maintain"
}

resource "github_team_repository" "shipping_admin" {
  team_id    = github_team.admins.id
  repository = github_repository.shippingservice.name
  permission = "admin"
}

resource "github_team_repository" "shipping_auditor" {
  team_id    = github_team.auditors.id
  repository = github_repository.shippingservice.name
  permission = "pull"
}
