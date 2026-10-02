workspace "Deployment Topology" "10 components, 12 connections, 2 zones, 4 ordered columns" {

    !identifiers flat

    model {
        sys = softwareSystem "Deployment Topology" {
            group "Edge" {
                browser = container "Browser"
                cdn = container "CDN"
                waf = container "WAF"
                alb = container "ALB"
            }
            group "App" {
                api = container "API"
                queue = container "Queue"
                worker = container "Worker"
                postgres = container "Postgres"
                objstore = container "Object Storage"
                metrics = container "Metrics"
            }
        }

        browser -> cdn "Requests"
        cdn -> waf "Forwards requests"
        waf -> alb "Forwards requests"
        alb -> api "Routes requests"
        api -> postgres "Reads and writes"
        api -> queue "Enqueues jobs"
        queue -> worker "Delivers jobs"
        worker -> postgres "Reads and writes"
        worker -> objstore "Uploads files"
        api -> objstore "Uploads files"
        api -> metrics "Publishes metrics"
        worker -> metrics "Publishes metrics"
    }

    views {
        container sys "Topology" {
            include *
            autoLayout lr 400 120
        }
    }

}
