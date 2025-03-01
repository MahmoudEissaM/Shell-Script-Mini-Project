 Shell Script Database Management System (DBMS)</h1>

<h2>📌 Project Overview</h2>
<p>This project is a <b>Database Management System (DBMS)</b> built using <b>Bash Shell Scripting</b>.  
It enables users to store and retrieve data directly from the <b>Hard Disk</b>.</p>

<h2>🚀 Features</h2>
<ul>
  <li><b>CLI Menu Based Application</b> with two levels of menus:</li>
  <ol>
    <li><b>Main Menu:</b>
      <ul>
        <li>📂 Create Database</li>
        <li>📋 List Databases</li>
        <li>🔗 Connect to Database</li>
        <li>❌ Drop Database</li>
      </ul>
    </li>
    <li><b>Database Menu (after connecting to a DB):</b>
      <ul>
        <li>📑 Create Table</li>
        <li>📋 List Tables</li>
        <li>❌ Drop Table</li>
        <li>✏️ Insert into Table</li>
        <li>🔍 Select From Table</li>
        <li>🗑️ Delete From Table</li>
        <li>🔄 Update Table</li>
      </ul>
    </li>
  </ol>
</ul>

<h2>🔧 How to Run the Project</h2>

<h3>Step 1: Open Terminal/Git Bash</h3>
<p>Make sure you have <b>Git Bash (Windows) or Terminal (Linux/Mac)</b> open.</p>

<h3>Step 2: Navigate to the Project Directory</h3>
<pre><code>cd /path/to/project</code></pre>
<p>For example:</p>
<pre><code>cd ~/Desktop/dbms-project</code></pre>

<h3>Step 3: Give Execution Permissions</h3>
<pre><code>chmod +x dbms.sh tables.sh</code></pre>

<h3>Step 4: Run the DBMS</h3>
<pre><code>./dbms.sh</code></pre>

<h2>📊 Database Structure</h2>
<ul>
  <li>Each <b>Database</b> is stored as a <b>directory</b>.</li>
  <li>Each <b>Table</b> is stored as a <b>file</b> inside its corresponding database.</li>
  <li>Tables have <b>column data types</b> and <b>Primary Key Constraints</b>.</li>
</ul>

<h2>🏆 Bonus Features</h2>
<ul>
  <li>Accepts SQL-like commands (optional).</li>
  <li>Future GUI Integration.</li>
</ul>

<hr>

<h2>👨‍💻 Developed By</h2>
<p><b>Mahmoud & Waheed</b></p>

<p>💡 <i>Feel free to modify and contribute!</i></p>
