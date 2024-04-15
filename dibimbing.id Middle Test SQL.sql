CREATE TABLE employee_table (
    employee TEXT NOT NULL,
    salary INTEGER
);

INSERT INTO employee_table (employee, salary) VALUES
('Alice', 11),
('Benn', 43),
('Charles', 33),
('Dorothy', 55),
('Emma', 22),
('Franklin', 33);

SELECT DISTINCT Salary AS third_highest_salary
FROM(
    SELECT Salary, RANK() OVER (ORDER BY Salary DESC) AS salary_rank
  FROM employee_table
  )
WHERE salary_rank = 3;

CREATE TABLE item_bought (
    buyer TEXT NOT NULL,
    item TEXT NOT NULL
);

INSERT INTO item_bought (buyer, item) VALUES
('A', 'Asus'),
('B', 'Lenovo'),
('C', 'Lenovo'),
('D', 'Acer'),
('E', 'Acer'),
('F', 'Acer');

SELECT item
FROM (
    SELECT item, RANK() OVER (ORDER BY COUNT(*) DESC) AS item_rank
    FROM item_bought
    GROUP BY item
)
WHERE item_rank = (
    SELECT (MAX(item_rank) + MIN(item_rank)) / 2
    FROM (
        SELECT RANK() OVER (ORDER BY COUNT(*) DESC) AS item_rank
        FROM item_bought
        GROUP BY item
) 
    );