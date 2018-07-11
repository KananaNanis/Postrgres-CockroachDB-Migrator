package com.radioafricagroup.cockroach.migrator;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Scanner;

public class NiiClassicMigrator {

  /*
    The algorithm for solving this problem is as follows:
    1. read original SQL file - DONE
    2. Create 2 HashMaps: - DONE
      a. {TblName -> PK}
      b. {TblName -> `Create DDL}
    3. Fill out HashMaps with the correct PK and Create DDL keyed by TblName
    4. Replace PK into Create DDL
    5. Combine Create DDLs
    6. Write to File
   */

  private ClassLoader classLoader = ClassicMigrator.class.getClassLoader();
  private File file;
  private Scanner scanner;
  private HashMap<String, String> pkHashMap = new HashMap();
  private HashMap<String, String> ddlHashMap = new HashMap();

  public String readOriginalFile(String filePath) {
    try {
      //file = new File(classLoader.getResource(filePath).toURI());
      byte[] encoded = Files.readAllBytes(Paths.get(filePath));
      return new String(encoded, StandardCharsets.UTF_8);
    } catch (FileNotFoundException e) {
      e.printStackTrace();
      return "";
    } catch (IOException e) {
      e.printStackTrace();
      return "";
    }
  }

  private int getStartCreateTableIndex(String input) {
    return input.indexOf("CREATE TABLE public.");
  }
  private int getEndCreateTableIndex(String input) {
    return input.indexOf("NOT NULL\r);");
  }
  private HashMap<String, String> getAllCreateStatements(String input) {
    int start = getStartCreateTableIndex(input);
    int end = getEndCreateTableIndex(input);

    System.out.println("Start: " + start);
    System.out.println("End: " + end);

    return input.substring(start, end);
  }
  private HashMap<String, String> getAllPK() {

  }

  public void fillOutHashMaps() {

  }
  public void replacePKIntoCreateDDL() {

  }

  public static void main(String[] args) {
    NiiClassicMigrator niiClassicMigrator = new NiiClassicMigrator();

    String filePath = "songa_billing_parent_dev_original.sql";
    String fileContents = niiClassicMigrator.readOriginalFile(filePath);
    //System.out.println(fileContents);

    String firstCreateDDLStatement = niiClassicMigrator.getCreateStatement(fileContents);
    System.out.println(firstCreateDDLStatement);
  }
}
