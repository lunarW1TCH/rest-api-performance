#[macro_use]
extern crate rocket;

#[get("/get")]
fn get() -> &'static str {
    "Hello World"
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![get])
}
