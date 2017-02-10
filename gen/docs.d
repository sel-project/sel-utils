/*
 * Copyright (c) 2016-2017 SEL
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU Lesser General Public License for more details.
 * 
 */
module docs;

import std.algorithm : min, max, canFind, sort;
import std.conv : to;
static import std.file;
import std.regex : ctRegex, replaceAll, matchFirst;
import std.string;
import std.typecons : Tuple, tuple;

import all;

void docs(Attributes[string] attributes, Protocols[string] protocols, Metadatas[string] metadatas) {
	
	std.file.mkdirRecurse("../docs");
	
	enum defaultTypes = ["bool", "byte", "ubyte", "short", "ushort", "int", "uint", "long", "ulong", "float", "double", "string", "varshort", "varushort", "varint", "varuint", "varlong", "varulong", "triad", "uuid", "bytes", "metadata"];
	
	@property string convert(string type) {
		auto end = min(cast(size_t)type.lastIndexOf("["), cast(size_t)type.lastIndexOf("<"), type.length);
		immutable t = type[0..end];
		immutable e = type[end..$].replace("<", "&lt;").replace(">", "&gt;");
		if(defaultTypes.canFind(t)) return t ~ e;
		else return "<a href=\"#" ~ link("types", t) ~ "\">" ~ toCamelCase(t) ~ "</a>" ~ e;
	}
	
	foreach(string game, Protocols ptrs; protocols) {
		immutable gameName = game[0..$-ptrs.protocol.to!string.length];
		auto attributes = game in attributes;
		auto metadata = game in metadatas;
		string data = head(ptrs.software ~ " " ~ ptrs.protocol.to!string, true, game, ptrs.data.description.length ? ptrs.data.description.replaceAll(ctRegex!`<[a-z0-9]+>|<\/[a-z0-9]+>`, "").replaceAll(ctRegex!`\[([a-zA-Z0-9_\-\. ]+)\]\([a-zA-Z0-9_\-\.:\#\/]+\)`, "$1").split("\n")[0].strip : "");
		data ~= "\t\t<h1>" ~ ptrs.software ~ " " ~ ptrs.protocol.to!string ~ "</h1>\n";
		uint[] others;
		foreach(otherGame, op; protocols) {
			if(otherGame != game && otherGame.startsWith(gameName)) {
				others ~= to!uint(otherGame[gameName.length..$]);
			}
		}
		if(others.length) {
			sort(others);
			string[] str;
			foreach(o ; others) {
				str ~= "<a href=\"diff/" ~ to!string(min(o, ptrs.protocol)) ~ "-" ~ to!string(max(o, ptrs.protocol)) ~ ".html\">" ~ to!string(o) ~ "</a>";
			}
			data ~= "\t\t<p><strong>Compare</strong>: " ~ str.join(", ") ~ "</p>\n";
		}
		string[] jumps = ["<a href=\"#endianness\">Endianness</a>", "<a href=\"#packets\">Packets</a>"];
		if(ptrs.data.types.length) jumps ~= "<a href=\"#types\">Types</a>";
		if(ptrs.data.arrays.length) jumps ~= "<a href=\"#arrays\">Arrays</a>";
		if(metadata) jumps ~= "<a href=\"#metadata\">Metadata</a>";
		if(attributes) jumps ~= "<a href=\"#attributes\">Attributes</a>";
		data ~= "\t\t<p><strong>Jump to</strong>: " ~ jumps.join(", ") ~ "</p>\n";
		if(ptrs.data.released.length) {
			auto spl = ptrs.data.released.split("/");
			if(spl.length == 3) {
				immutable day = spl[2] ~ (){
					auto ret = spl[2];
					if(spl[2].length != 2 || spl[0][$-2] == '1') {
						if(spl[2][$-1] == '1') return "st";
						else if(spl[2][$-1] == '2') return "nd";
						else if(spl[2][$-1] == '3') return "rd";
					}
					return "th";
				}();
				immutable month = (){
					final switch(to!size_t(spl[1])) {
						case 1: return "January";
						case 2: return "February";
						case 3: return "March";
						case 4: return "April";
						case 5: return "May";
						case 6: return "June";
						case 7: return "July";
						case 8: return "August";
						case 9: return "September";
						case 10: return "October";
						case 11: return "November";
						case 12: return "December";
					}
				}();
				data ~= "\t\t<p><strong>Released</strong>: " ~ month ~ " " ~ day ~ ", " ~ spl[0] ~ "</p>\n";
			}
		}
		if(ptrs.data.from.length) {
			data ~= "\t\t<p>";
			if(ptrs.data.to.length) {
				if(ptrs.data.from == ptrs.data.to) data ~= "Used in version <strong>" ~ ptrs.data.from ~ "</strong>";
				else data ~= "Used from version <strong>" ~ ptrs.data.from ~ "</strong> to <strong>" ~ ptrs.data.to ~ "</strong>";
			} else {
				data ~= "In use since version <strong>" ~ ptrs.data.from ~ "</strong>";
			}
			data ~= "</p>\n";
		}
		if(ptrs.data.description.length) data ~= desc("\t\t", ptrs.data.description);
		data ~= "\t\t<hr>\n";
		// field (generic)
		void writeFields(string[] namespace, Field[] fields, size_t spaces, string fieldDesc="Fields") {
			string space;
			foreach(i ; 0..spaces) space ~= "\t";
			if(fields.length) {
				data ~= space ~ "<p><strong>" ~ fieldDesc ~ "</strong>:</p>\n";
				bool endianness, condition;
				foreach(field ; fields) {
					endianness |= field.endianness.length != 0;
					condition |= field.condition.length != 0;
				}
				data ~= space ~ "<table>\n";
				data ~= space ~ "\t<tr><th>Name</th><th>Type</th>" ~ (endianness ? "<th>Endianness</th>" : "") ~ (condition ? "<th>When</th>" : "") ~ "</tr>\n";
				foreach(field ; fields) {
					data ~= space ~ "\t<tr><td>";
					if(field.description.length || field.constants.length) data ~= "<a href=\"#" ~ link(namespace ~ field.name) ~ "\">" ~ toCamelCase(field.name) ~ "</a>";
					else data ~= toCamelCase(field.name);
					data ~= "</td><td>" ~ convert(field.type) ~ "</td>";
					if(endianness) data ~= "<td class=\"center\">" ~ field.endianness.replace("_", " ") ~ "</td>";
					if(condition) data ~= "<td class=\"center\">" ~ (field.condition.length ? cond(toCamelCase(field.condition)) : "") ~ "</td>";
					data ~= "</tr>\n";
				}
				data ~= space ~ "</table>\n";
				if(fields.length) {
					data ~= space ~ "<ul>\n";
					foreach(field ; fields) {
						if(field.description.length || field.constants.length) {
							data ~= space ~ "\t<li>\n";
							data ~= space ~ "\t\t<strong id=\"" ~ link(namespace ~ field.name) ~ "\">" ~ toCamelCase(field.name) ~ "</strong>\n";
							if(field.description.length) data ~= desc(space ~ "\t\t", field.description);
							if(field.constants.length) {
								bool notes;
								foreach(constant ; field.constants) {
									if(constant.description.length) {
										notes = true;
										break;
									}
								}
								data ~= space ~ "\t\t<p><strong>Constants</strong>:</p>\n";
								data ~= space ~ "\t\t<table>\n";
								data ~= space ~ "\t\t\t<tr><th>Name</th><th>Value</th>" ~ (notes ? "<th></th>" : "") ~ "</tr>\n";
								foreach(constant ; field.constants) {
									data ~= space ~ "\t\t\t<tr><td>" ~ toCamelCase(constant.name) ~ "</td><td class=\"center\">" ~ constant.value ~ "</td>" ~ (notes ? "<td>" ~ constant.description ~ "</td>" : "") ~ "</tr>\n";
								}
								data ~= space ~ "\t\t</table>\n";
							}
							data ~= space ~ "\t</li>\n";
						}
					}
					data ~= space ~ "</ul>\n";
				}
			}
		}
		// endianness
		data ~= "\t\t<h2 id=\"endianness\">Endianness</h2>\n";
		data ~= "\t\t<table>\n";
		string def = "big_endian";
		string[string] change;
		foreach(string type, string end; ptrs.data.endianness) {
			if(type != "*") change[type] = end;
		}
		string[] be, le;
		string[] used;
		foreach(string type ; ["short", "ushort", "int", "uint", "long", "ulong", "float", "double"]) {
			(){
				bool checkImpl(string ft) {
					auto t = ft in ptrs.data.arrays;
					if(t ? (*t).base.startsWith(type) || (*t).length.startsWith(type) : ft.startsWith(type)) {
						auto e = type in change ? change[type] : def;
						if(e == "big_endian") be ~= type;
						else le ~= type;
						return true;
					}
					return false;
				}
				bool check(Field field) {
					return !field.endianness.length && checkImpl(field.type);
				}
				if(checkImpl(ptrs.data.id)) return;
				if(checkImpl(ptrs.data.arrayLength)) return;
				foreach(type ; ptrs.data.types) {
					foreach(field ; type.fields) if(check(field)) return;
				}
				foreach(section ; ptrs.data.sections) {
					foreach(packet ; section.packets) {
						foreach(field ; packet.fields) if(check(field)) return;
						foreach(variant ; packet.variants) {
							foreach(field ; variant.fields) if(check(field)) return;
						}
					}
				}
			}();
		}
		data ~= "\t\t\t<tr><td>big endian</td><td>" ~ be.join(", ") ~ "</td></tr>\n";
		data ~= "\t\t\t<tr><td>little endian</td><td>" ~ le.join(", ") ~ "</td></tr>\n";
		data ~= "\t\t</table>\n";
		data ~= "\t\t<p><strong>Ids</strong>: " ~ ptrs.data.id ~ "</p>\n";
		data ~= "\t\t<p><strong>Array's length</strong>: " ~ ptrs.data.arrayLength ~ "</p>\n";
		data ~= "\t\t<hr>\n";
		// sections (legend)
		data ~= "\t\t<h2 id=\"packets\">Packets</h2>\n";
		data ~= "\t\t<table>\n";
		data ~= "\t\t\t<tr><th>Section</th><th>Packets</th></tr>\n";
		foreach(section ; ptrs.data.sections) {
			data ~= "\t\t\t<tr><td><a href=\"#" ~ section.name.replace("_", "-") ~ "\">" ~ pretty(toCamelCase(section.name)) ~ "</a></td><td class=\"center\">" ~ to!string(section.packets.length) ~ "</td></tr>\n";
		}
		data ~= "\t\t</table>\n";
		// sections
		foreach(section ; ptrs.data.sections) {
			data ~= "\t\t<h3 id=\"" ~ link(section.name) ~ "\">" ~ pretty(toCamelCase(section.name)) ~ "</h3>\n";
			if(section.description.length) data ~= desc("\t\t", section.description);
			data ~= "\t\t<table>\n";
			data ~= "\t\t\t<tr><th>Packets</th><th colspan=\"2\">Id</th><th>Clientbound</th><th>Serverbound</th></tr>\n";
			foreach(packet ; section.packets) {
				data ~= "\t\t\t<tr>";
				data ~= "<td><a href=\"#" ~ link(section.name, packet.name) ~ "\">" ~ pretty(toCamelCase(packet.name)) ~ "</a></td>";
				data ~= "<td class=\"center\">" ~ packet.id.to!string ~ "</td>";
				data ~= "<td class=\"center\">" ~ ("0" ~ packet.id.to!string(16))[$-2..$] ~ "₁₆</td>";
				data ~= "<td class=\"center\">" ~ (packet.clientbound ? "✓" : "") ~ "</td>";
				data ~= "<td class=\"center\">" ~ (packet.serverbound ? "✓" : "") ~ "</td>";
				data ~= "</tr>\n";
			}
			data ~= "\t\t</table>\n";
			// packets
			data ~= "\t\t<ul>\n";
			foreach(packet ; section.packets) {
				data ~= "\t\t\t<li>\n";
				data ~= "\t\t\t\t<h3 id=\"" ~ link(section.name, packet.name) ~ "\">" ~ pretty(toCamelCase(packet.name)) ~ "</h3>\n";
				/*data ~= "\t\t\t\t<p><strong>Id</strong>: " ~ to!string(packet.id) ~ "</p>\n";
				data ~= "\t\t\t\t<p><strong>Clientbound</strong>: " ~ (packet.clientbound ? "yes" : "no") ~ "</p>\n";
				data ~= "\t\t\t\t<p><strong>Serverbound</strong>: " ~ (packet.serverbound ? "yes" : "no") ~ "</p>\n";*/
				data ~= "\t\t\t\t<table>\n";
				data ~= "\t\t\t\t\t<tr><th colspan=\"3\">Id</th><th>Clientbound</th><th>Serverbound</th></tr>\n";
				data ~= "\t\t\t\t\t<tr><td class=\"center\">" ~ packet.id.to!string ~ "</td>";
				data ~= "<td class=\"center\">" ~ ("00000000" ~ packet.id.to!string(2))[$-8..$] ~ "₂</td>";
				data ~= "<td class=\"center\">" ~ ("00" ~ packet.id.to!string(16))[$-2..$] ~ "₁₆</td>";
				data ~= "<td class=\"center\">" ~ (packet.clientbound ? "✓" : "") ~ "</td>";
				data ~= "<td class=\"center\">" ~ (packet.serverbound ? "✓" : "") ~ "</td></tr>\n";
				data ~= "\t\t\t\t</table>\n";
				if(packet.description.length) data ~= desc("\t\t\t\t", packet.description);
				writeFields([section.name, packet.name], packet.fields, 4);
				if(packet.variants.length) {
					data ~= "\t\t\t\t<p><strong>Variants</strong>:</p>\n";
					data ~= "\t\t\t\t<table>\n";
					data ~= "\t\t\t\t\t<tr><th>Variant</th><th>Field</th><th>Value</th></tr>\n";
					foreach(variant ; packet.variants) {
						data ~= "\t\t\t\t\t<tr><td><a href=\"#" ~ link(section.name, packet.name, variant.name) ~ "\">" ~ pretty(toCamelCase(variant.name)) ~ "</a></td><td>" ~ toCamelCase(packet.variantField) ~ "</td><td class=\"center\">" ~ variant.value ~ "</td></tr>\n";
					}
					data ~= "\t\t\t\t</table>\n";
					data ~= "\t\t\t\t<ul>\n";
					foreach(variant ; packet.variants) {
						data ~= "\t\t\t\t\t<li>\n";
						data ~= "\t\t\t\t\t\t<h3 id=\"" ~ link(section.name, packet.name, variant.name) ~ "\">" ~ pretty(toCamelCase(variant.name)) ~ "</h3>\n";
						if(variant.description.length) data ~= desc("\t\t\t\t\t\t", variant.description);
						writeFields([section.name, packet.name, variant.name], variant.fields, 6, "Additional Fields");
						data ~= "\t\t\t\t\t</li>\n";
					}
					data ~= "\t\t\t\t</ul>\n";
				}
				data ~= "\t\t\t</li>\n";
			}
			data ~= "\t\t</ul>\n";
		}
		// types
		if(ptrs.data.types.length) {
			data ~= "\t\t<hr>\n";
			data ~= "\t\t<h2 id=\"types\">Types</h2>\n";
			if(ptrs.data.types.length > 3) {
				string[] jt;
				foreach(type ; ptrs.data.types) {
					jt ~= "<a href=\"#" ~ link("types", type.name) ~ "\">" ~ pretty(toCamelCase(type.name)) ~ "</a>";
				}
				data ~= "\t\t<p><strong>Jump to</strong>: " ~ jt.join(", ") ~ "</p>\n";
			}
			data ~= "\t\t<ul>\n";
			foreach(type ; ptrs.data.types) {
				data ~= "\t\t\t<li>\n";
				data ~= "\t\t\t\t<h3 id=\"" ~ link("types", type.name) ~ "\">" ~ pretty(toCamelCase(type.name)) ~ "</h3>\n";
				if(type.description.length) data ~= desc("\t\t\t\t", type.description);
				writeFields(["types", type.name], type.fields, 4);
				data ~= "\t\t\t</li>\n";
			}
			data ~= "\t\t</ul>\n";
		}
		// arrays
		if(ptrs.data.arrays.length) {
			data ~= "\t\t<hr>\n";
			data ~= "\t\t<h2 id=\"arrays\">Arrays</h2>\n";
			bool e = false;
			foreach(a ; ptrs.data.arrays) {
				e |= a.endianness.length != 0;
			}
			data ~= "\t\t<table>\n";
			data ~= "\t\t\t<tr><th>Name</th><th>Base</th><th>Length</th>" ~ (e ? "<th>Length's Endianness</th>" : "") ~ "</tr>\n";
			foreach(name, a ; ptrs.data.arrays) {
				data ~= "\t\t\t<tr id=\"" ~ link("types", name) ~ "\"><td>" ~ toCamelCase(name) ~ "</td><td>" ~ convert(a.base) ~ "</td><td>" ~ convert(a.length) ~ "</td>" ~ (e ? "<td>" ~ a.endianness.replace("_", " ") ~ "</td>" : "") ~ "</tr>\n";
			}
			data ~= "\t\t</table>\n";
		}
		// metadata
		if(metadata) {
			data ~= "\t\t<hr>\n";
			data ~= "\t\t<h2 id=\"metadata\">Metadata</h2>\n";
			data ~= "\t\t<ul>\n";
			// encoding
			data ~= "\t\t\t<li>\n";
			data ~= "\t\t\t\t<h3>Encoding</h3>\n";
			if((*metadata).data.prefix.length) data ~= "\t\t\t\t<p><strong>Prefix</strong>: " ~ (*metadata).data.prefix ~ "</p>\n";
			if((*metadata).data.length.length) data ~= "\t\t\t\t<p><strong>Length</strong>: " ~ (*metadata).data.length ~ "</p>\n";
			/*data ~= "[\n\n";
			data ~= "   Value's type (" ~ (*metadata).data.type ~ "\n\n";
			data ~= "   Value's id (" ~ (*metadata).data.id ~ "\n\n";
			data ~= "   Value (type varies)\n\n";
			data ~= "]\n\n";*/
			if((*metadata).data.suffix.length) data ~= "\t\t\t\t<p><strong>Suffix</strong>: " ~ (*metadata).data.suffix ~ "</p>\n";
			data ~= "\t\t\t</li>\n";
			// type
			data ~= "\t\t\t<li>\n";
			data ~= "\t\t\t\t<h3>Types</h3>\n";
			data ~= "\t\t\t\t<table>\n";
			data ~= "\t\t\t\t\t<tr><th>Name</th><th>Type</th><th>Id</th></tr>\n";
			foreach(type ; (*metadata).data.types) {
				data ~= "\t\t\t\t\t<tr><td>" ~ toCamelCase(type.name) ~ "</td><td>" ~ convert(type.type) ~ "</td><td class=\"center\">" ~ type.id.to!string ~ "</td></tr>\n";
			}
			data ~= "\t\t\t\t</table>\n";
			data ~= "\t\t\t</li>\n";
			// data
			data ~= "\t\t\t<li>\n";
			data ~= "\t\t\t\t<h3>Data</h3>\n";
			data ~= "\t\t\t\t<table>\n";
			data ~= "\t\t\t\t\t<tr><th>Name</th><th>Type</th><th colspan=\"2\">Id</th><th>Default</th><th>Required</th></tr>\n";
			foreach(meta ; (*metadata).data.data) {
				data ~= "\t\t\t\t\t<tr><td>";
				immutable name = pretty(toCamelCase(meta.name));
				if(meta.description.length || meta.flags.length) data ~= "<a href=\"#" ~ link("metadata", meta.name) ~ "\">" ~ name ~ "</a>";
				else data ~= name;
				data ~= "</td><td>" ~ convert(meta.type) ~ "</td><td class=\"center\">" ~ meta.id.to!string ~ "</td><td class=\"center\">" ~ meta.id.to!string(16) ~ "₁₆</td><td class=\"center\">" ~ meta.def ~ "</td><td class=\"center\">" ~ (meta.required ? "✓" : "") ~ "</td></tr>\n";
			}
			data ~= "\t\t\t\t</table>\n";
			data ~= "\t\t\t\t<ul>\n";
			foreach(meta ; (*metadata).data.data) {
				if(meta.description.length || meta.flags.length) {
					data ~= "\t\t\t\t\t<li>\n";
					data ~= "\t\t\t\t\t<h4 id=\"" ~ link("metadata", meta.name) ~ "\">" ~ pretty(toCamelCase(meta.name)) ~ "</h4>\n";
					if(meta.description.length) data ~= desc("\t\t\t\t\t", meta.description);
					if(meta.flags.length) {
						bool description;
						foreach(flag ; meta.flags) {
							if(flag.description.length) {
								description = true;
								break;
							}
						}
						data ~= "\t\t\t\t\t<table>\n";
						data ~= "\t\t\t\t\t\t<tr><th>Flag</th><th colspan=\"2\">Bit</th>" ~ (description ? "<th>Description</th>" : "") ~ "</tr>\n";
						foreach(flag ; meta.flags) {
							data ~= "\t\t\t\t\t\t<tr><td>" ~ toCamelCase(flag.name) ~ "</td><td class=\"center\">" ~ flag.bit.to!string ~ "</td><td class=\"center\">" ~ flag.bit.to!string(16) ~ "₁₆</td>" ~ (description ? "<td>" ~ flag.description.replace("\n", " ") ~ "</td>" : "") ~ "</tr>\n";
						}
						data ~= "\t\t\t\t\t</table>\n";
					}
					data ~= "\t\t\t\t\t</li>\n";
				}
			}
			data ~= "\t\t\t\t</ul>\n";
			data ~= "\t\t\t</li>\n";
			data ~= "\t\t</ul>\n";
		}
		// attributes
		if(attributes) {
			data ~= "\t\t<hr>\n";
			data ~= "\t\t<h2 id=\"attributes\">Attributes</h2>\n";
			data ~= "\t\t<table>\n";
			data ~= "\t\t\t<tr><th>Name</th><th>Key</th><th>Min</th><th>Max</th><th>Default</th></tr>\n";
			foreach(attribute ; (*attributes).data) {
				data ~= "\t\t\t<tr><td>" ~ pretty(toCamelCase(attribute.id)) ~ "</td><td>" ~ attribute.name ~ "</td><td class=\"center\">" ~ attribute.min.to!string ~ "</td><td class=\"center\">" ~ attribute.max.to!string ~ "</td><td class=\"center\">" ~ attribute.def.to!string ~ "</td></tr>\n";
			}
			data ~= "\t\t</table>\n";
		}
		data ~= "\t</body>\n</html>\n";
		immutable ps = ptrs.protocol.to!string;
		std.file.mkdirRecurse("../docs/" ~ game[0..$-ps.length]);
		std.file.write("../docs/" ~ game[0..$-ps.length] ~ "/" ~ ps ~ ".html", data);
	}
	
	// index
	Tuple!(Protocol, size_t, string)[][string] p;
	foreach(game, prts; protocols) {
		p[prts.software] ~= tuple(prts.data, prts.protocol, game);
	}
	string data = head("Index", false);
	foreach(string name ; ["Minecraft", "Minecraft: Pocket Edition", "Raknet", "Hub-Node Communication", "External Console"]) {
		size_t date(string str) {
			auto spl = str.split("/");
			return (to!size_t(spl[0]) * 366 + to!size_t(spl[1])) * 31 + to!size_t(spl[2]);
		}
		auto sorted = sort!((a, b) => date(a[0].released) > date(b[0].released))(p[name]).release();
		bool _released, _from, _to;
		foreach(pr ; sorted) {
			_released |= pr[0].released.length != 0;
			_from |= pr[0].from.length != 0;
			_to |= pr[0].to.length != 0;
		}
		data ~= "\t\t<h2>" ~ name ~ "</h2>\n";
		data ~= "\t\t<table>\n";
		data ~= "\t\t\t<tr>\n";
		data ~= "\t\t\t\t<th>Protocol</th>\n";
		data ~= "\t\t\t\t<th>Packets</th>\n";
		if(_released) data ~= "\t\t\t\t<th>Released</th>\n";
		if(_from) data ~= "\t\t\t\t<th>From</th>\n";
		if(_to) data ~= "\t\t\t\t<th>To</th>\n";
		data ~= "\t\t\t</tr>\n";
		foreach(cp ; sorted) {
			immutable ps = to!string(cp[1]);
			size_t packets = 0;
			foreach(section ; cp[0].sections) packets += section.packets.length;
			data ~= "\t\t\t<tr>\n";
			data ~= "\t\t\t\t<td class=\"center\"><a href=\"" ~ cp[2][0..$-ps.length] ~ "/" ~ ps ~ ".html\">" ~ ps ~ "</a></td>\n";
			data ~= "\t\t\t\t<td class=\"center\">" ~ to!string(packets) ~ "</td>\n";
			if(_released) data ~= "\t\t\t\t<td class=\"center\">" ~ cp[0].released ~ "</td>\n";
			if(_from) data ~= "\t\t\t\t<td class=\"center\">" ~ cp[0].from ~ "</td>\n";
			if(_to) data ~= "\t\t\t\t<td class=\"center\">" ~ cp[0].to ~ "</td>\n";
			data ~= "\t\t\t</tr>\n";
		}
		data ~= "\t\t</table>\n";
	}
	data ~= "\t</body>\n</html>\n";
	std.file.write("../docs/index.html", data);

	// minify style.css
	std.file.write("../docs/style.min.css", (cast(string)std.file.read("../docs/style.css")).replaceAll(ctRegex!`[\r\n\t]*`, "").replaceAll(ctRegex!`[ ]*([\{\:\,])[ ]*`, "$1"));
	
}

string head(string title, bool back, string xml="", string description="") {
	string b = back ? "../" : "";
	return "<!DOCTYPE html>\n<html lang=\"en\">\n" ~
			"\t<head>\n\t\t<meta charset=\"UTF-8\" />\n" ~
			"\t\t<title>" ~ title ~ " | SEL Utils</title>\n" ~
			"\t\t<meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" />\n" ~
			(description.length ? "\t\t<meta name=\"description\" content=\"" ~ description.replace(`"`, `\"`) ~ "\" />\n" : "") ~
			"\t\t<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/styles/github.min.css\" />\n" ~
			"\t\t<script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/highlight.min.js\"></script>\n" ~
			"\t\t<script>hljs.initHighlightingOnLoad();</script>\n" ~
			"\t\t<link rel=\"icon\" type=\"image/png\" href=\"" ~ b ~ "favicon.png\" />\n" ~
			"\t\t<link rel=\"stylesheet\" href=\"" ~ b ~ "style.min.css\" />\n\t</head>\n" ~
			"\t<body>\n\t\t<div class=\"logo\"><a href=\"" ~ b ~ "\"><div><img src=\"" ~ b ~ "logo.png\" alt=\"SEL\" /></div></a>" ~
			"<div><a href=\"" ~ b ~ "\">Index</a>&nbsp;&nbsp;" ~
			"<a href=\"https://github.com/sel-project/sel-utils/blob/master/README.md\">About</a>&nbsp;&nbsp;" ~
			"<a href=\"https://github.com/sel-project/sel-utils/blob/master/TYPES.md\">Types</a>&nbsp;&nbsp;" ~
			"<a href=\"https://github.com/sel-project/sel-utils/blob/master/CONTRIBUTING.md\">Contribute</a>&nbsp;&nbsp;" ~
			(xml.length ? "<a href=\"https://github.com/sel-project/sel-utils/blob/master/xml/protocol/" ~ xml ~ ".xml\">XML</a>&nbsp;&nbsp;" : "") ~
			"<a href=\"https://github.com/sel-project/sel-utils\">Github</a></div></div>\n";
}

@property string pretty(string name) {
	string ret;
	foreach(c ; name) {
		if(c >= 'A' && c <= 'Z' || c >= '0' && c <= '9') ret ~= ' ';
		ret ~= c;
	}
	if(!ret.length) return ret;
	else return (toUpper(ret[0..1]) ~ ret[1..$]).replace(" And ", " and ").replace(" Of ", " of ").replace(" In ", " in ");
}

string link(string[] pieces...) {
	foreach(ref piece ; pieces) piece = piece.replace("_", "-");
	return pieces.join("_");
}

string desc(string space, string description) {
	string ret;
	bool code = false, list = false;
	foreach(s ; description
		.replaceAll(ctRegex!`[\r\t]+`, "")
		.replaceAll(ctRegex!`\[([a-zA-Z0-9_\-\.]+)\]\((#[a-z0-9_\-]+)\)`, `<a href="$2">$1</a>`)
		.replaceAll(ctRegex!`\[([a-zA-Z0-9_\-\. ]+)\]\(([a-zA-Z0-9_\-\.\:\/\#]+)\)`, `<a href="$2" target="_blank">$1</a>`)
		.split("\n")) {

		if(code) {
			if(s.startsWith("```")) {
				ret ~= "</code></pre>\n";
				code = false;
			} else {
				ret ~= s ~ "\n";
			}
		} else {
			if(!s.length) continue;
			if(s.startsWith("+ ")) {
				if(!list) {
					ret ~= space ~ "<ul>\n";
					list = true;
				}
				ret ~= space ~ "\t<li>" ~ s[2..$].strip ~ "</li>\n";
				continue;
			} else if(list) {
				ret ~= space ~ "</ul>\n";
				list = false;
			}
			if(s.startsWith("```")) {
				ret ~= space ~ "<pre><code class=\"" ~ s[3..$] ~ "\">";
				code = true;
			} else {
				string h = "######";
				while((h = h[1..$]).length) {
					if(s.startsWith(h)) {
						ret ~= space ~ "<h" ~ to!string(h.length) ~ ">" ~ s[h.length..$].strip ~ "</h" ~ to!string(h.length) ~ ">\n";
						break;
					}
				}
				if(!h.length) ret ~= space ~ "<p>" ~ s.replaceAll(ctRegex!"`([^`]+)`", `<code>$1</code>`) ~ "</p>\n";
			}
		}
	}
	return ret;
}

string cond(string c) {
	c = "$+code$-" ~ c
		.replace("&", " & ")
		.replace("|", " | ")
		.replace("& &", "&&")
		.replace("| |", "||")
		.replace("==true", "$+/code$- is $+code$-$+span style=\"color:#009688\"$-true$+/span$-")
		.replace("==false", "$+/code$- is $+code$-$+span style=\"color:#009688\"$-false$+/span$-")
		.replace("==", "$+/code$- is equal to $+code$-")
		.replace("!=", "$+/code$- is not equal to $+code$-")
		.replace(">=", "$+/code$- is greater than or equal to $+code$-")
		.replace("<=", "$+/code$- is less than or equal to $+code$-")
		.replace(">", "$+/code$- is greater than $+code$-")
		.replace("<", "$+/code$- is less than $+code$-") ~ "$+/code$-";
	return c.replace("$+", "<").replace("$-", ">");
}
