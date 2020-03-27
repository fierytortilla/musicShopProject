# Literally Music Shop

**Music Shop Inventory**

An app will be constructed to allow a music shopkeeper to track their shop's inventory (who is buying and who is selling). This is not an app which the customer will see, it is an admin/management app for the shop workers.

MVP

The inventory should track individual products, including a name, description, stock quantity, buying cost, and selling price.
The inventory should track manufacturers, including a name and any other appropriate details.
Show an inventory page, listing all the details for all the products in stock in a single view.
As well as showing stock quantity as a number, the app should visually highlight "low stock" and "out of stock" items to the user.

Inspired by
Reverb, Amazon (back end only)

Possible Extensions

* Calculate the markup on items in the store, and display it in the inventory
*  Filter the inventory list by manufacturer. For example, provide an option to view all books in stock by a certain author.
*  Categorise your items. Music gear might be categorised by type (guitar, synthesizer, amplifiers, software...) and might be categorised by manufacturer (Fender, Earthquaker Devices, Blackstar...). Provide an option to filter the inventory list by these categories.
*  Make it possible for buyer to become a seller and put up their used gear for sale on the site.

# Tables
**Site-Map**

The tentative site-map.
![site-map](https://user-images.githubusercontent.com/29728677/77705921-d5cf0000-6fb8-11ea-807d-d2cc1ef2e94f.png)

**UML of Models in DB**

Each of the models corresponds to a table in the PostGreSQL database which is accessed by our site.

![uml-design2](https://user-images.githubusercontent.com/29728677/77708010-c0f56b00-6fbe-11ea-8821-1a3ad1ee48d4.png)
