# PostgreSQL Q and A

## Disclaimer

Some questions are loosely formulated, and some answers may be not exact. This Q and A shall rather stimulate one's memory of PostgreSQL than be a fact-checking exercise. For exact and accurate information refer to the documentation itself.

TODO

## 5.10.1. Creating a Schema

Why can a user not create a schema with the name beginning with `pg_`?

Such names are reserved for system purposes.

TODO

## 5.10.5. The System Catalog Schema

What does the `pg_catalog` schema contain?

System tables, and built-in data types, functions, and operators.

---

If the `pg_catalog` schema is not explicitly part of the search path, it is implicitly searched anyway. Does it happen before or after searching the schemas in the search path?

Before.

## 5.10.6. Usage Patterns

Does there exist a secure schema usage pattern if an untrusted user is the database owner?

No.

---

Does there exist a secure schema usage pattern if an untrusted user has been granted `ADMIN OPTION` on a relevant role?

No.

## 5.10.7. Portability

When would you not want to use the public schema?

If you wanted maximum conformance to the SQL standard.

## 5.11. Inheritance

How similar is SQL:1999 and later's type inheritance to PostgreSQL's inheritance?

It differs in many respects.

---

What key word introduces inheritance to a table?

`INHERITS`.

---

Does PostgreSQL support inheritance from multiple tables?

Yes.

---

What key word should you use in a query to indicate that you do not want to refer to descendant tables?

`ONLY`.

---

What does the column `tableoid`, of any table, contain?

The OID of the originating table.

---

There are two types of constraints inherited automatically. Which ones?

Check constraints and not-null constraints.

---

What happens if the same column name appears in multiple parent tables, or in both a parent table and the child's definition?

All the columns are tried to be "merged".

---

Can a table start to inherit after it is created?

Yes.

---

Can a table stop to inherit after it is created?

Yes.

---

Can you drop a table without dropping its descendant tables?

No.

---

Can foreign tables be part of inheritance hierarchies?

Yes.

### 5.11.1. Caveats

Can all SQL commands work on inheritance hierarchies?

No.

---

TODO