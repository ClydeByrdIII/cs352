package edu.purdue.cs352.minijava.parser;

public class Tokens {
	private String token;
	private int type;
	final static int ID = 0;
	final static int NUM = 1;
	final static int SYM = 2;
	final static int KEY = 3;
	
	public String toString() {
		return token;
	}
	
	public int getType() {
		return type;
	}
	public Tokens(String token, int type) {
		this.token = token;
		this.type = type;
	}
}