/*
 * Copyright (c) 2016-2018 sel-project
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */
module app;

import std.algorithm : canFind, min;
import std.conv : to;
import std.file : dirEntries, SpanMode, exists, read, isFile, _write = write;
import std.json : parseJSON;
import std.path : dirSeparator;
import std.process : environment;
import std.regex : ctRegex, replaceAll;
import std.string;
import std.xml;

import soupply.data;
import soupply.generator;

void main(string[] args) {
	
	args = args[1..$];
	
	if(args.canFind("-h") || args.canFind("--help")) {
		//TODO write help
		return;
	}

	// parse xml files in data/
	Info[string] data;
	foreach(string file ; dirEntries("data/", SpanMode.breadth)) {
		if(file.isFile && file.endsWith(".xml")) {
			Info info = Info(file);
			string[string] aliases;
			size_t arrays = 1;
			@property string convert(string type) {
				auto end = min(cast(size_t)type.lastIndexOf("["), cast(size_t)type.lastIndexOf("<"), type.length);
				auto t = type[0..end];
				auto a = t in aliases;
				if(a) t = *a;
				return t ~ type[end..$];
			}
			Protocol.Field parseField(Element element) {
				Protocol.Field field;
				with(element.tag) {
					field.name = attr["name"].rename();
					field.type = convert(attr["type"].rename());
					if("endianness" in attr) field.endianness = attr["endianness"].rename();
					if("length" in attr) field.length = convert(attr["length"].rename());
					if("lengthendianness" in attr) field.lengthEndianness = attr["lengthendianness"].rename();
					if("when" in attr) field.condition = attr["when"].rename();
					if("default" in attr) field.default_ = attr["default"];
					field.description = text(element);
					if("typename" in attr) {
						Protocol.Type type;
						type.name = convert(attr["typename"].rename());
						if("prelength" in attr) type.length = attr["prelength"].length ? convert(attr["prelength"].rename()) : info.protocol.arrayLength;
						foreach(f ; element.elements) {
							if(f.tag.name == "field") {
								type.fields ~= parseField(f);
							}
						}
						info.protocol.types ~= type;
					}
				}
				foreach(c ; element.elements) {
					if(c.tag.name == "constant") {
						field.constants ~= Protocol.Constant(c.tag.attr["name"].rename(), text(c), c.tag.attr["value"]);
					}
				}
				return field;
			}
			foreach(element ; new Document(cast(string)read(file)).elements) {
				switch(element.tag.name) {
					case "software":
						info.software = text(element);
						break;
					case "protocol":
						immutable protocol = text(element);
						info.game = file[5..$-protocol.length-4];
						info.version_ = protocol.to!uint;
						break;
					case "released":
						info.released = text(element);
						break;
					case "from":
						info.from = text(element);
						break;
					case "to":
						info.to = text(element);
						break;
					case "description":
						info.description = text(element);
						break;
					case "encoding":
						info.protocol.id = element.tag.attr["id"];
						info.protocol.arrayLength = element.tag.attr["arraylength"];
						info.protocol.endianness = element.tag.attr["endianness"].rename();
						if("padding" in element.tag.attr) info.protocol.padding = to!size_t(element.tag.attr["padding"]);
						foreach(e ; element.elements) {
							switch(e.tag.name) {
								case "alias":
									with(e.tag) aliases[attr["name"].rename()] = attr["type"].rename();
									break;
								case "type":
									Protocol.Type type;
									type.name = e.tag.attr["name"].rename();
									type.description = text(e);
									if("prelength" in e.tag.attr) type.length = e.tag.attr["prelength"].length ? convert(e.tag.attr["prelength"].rename()) : info.protocol.arrayLength;
									else if("length" in e.tag.attr) type.length = e.tag.attr["length"].length ? convert(e.tag.attr["length"].rename()) : info.protocol.arrayLength;
									foreach(f ; e.elements) {
										if(f.tag.name == "field") {
											type.fields ~= parseField(f);
										}
									}
									info.protocol.types ~= type;
									break;
								default:
									break;
							}
						}
						break;
					case "packets":
						foreach(s ; element.elements) {
							if(s.tag.name == "section") {
								Protocol.Section section;
								section.name = s.tag.attr["name"].rename();
								section.description = text(s);
								foreach(pk ; s.elements) {
									if(pk.tag.name == "packet") {
										Protocol.Packet packet;
										packet.name = pk.tag.attr["name"].rename();
										packet.id = pk.tag.attr["id"].to!uint;
										packet.clientbound = to!bool(pk.tag.attr.get("clientbound", "false"));
										packet.serverbound = to!bool(pk.tag.attr.get("serverbound", "false"));
										packet.description = text(pk);
										foreach(fv ; pk.elements) {
											if(fv.tag.name == "field") {
												packet.fields ~= parseField(fv);
											} else if(fv.tag.name == "variants") {
												packet.variantField = fv.tag.attr["field"].rename();
												foreach(v ; fv.elements) {
													if(v.tag.name == "variant") {
														Protocol.Variant variant;
														variant.name = v.tag.attr["name"].rename();
														variant.value = v.tag.attr["value"].rename();
														variant.description = text(v);
														foreach(f ; v.elements) {
															if(f.tag.name == "field") {
																variant.fields ~= parseField(f);
															}
														}
														packet.variants ~= variant;
													}
												}
											} else if(fv.tag.name == "test") {
												packet.tests ~= parseJSON(text(fv));
											}
										}
										section.packets ~= packet;
									}
								}
								info.protocol.sections ~= section;
							}
						}
						break;
					case "metadata":
						foreach(e ; element.elements) {
							switch(e.tag.name) {
								case "encoding":
									if("prefix" in e.tag.attr) info.metadata.prefix = e.tag.attr["prefix"];
									if("length" in e.tag.attr) info.metadata.length = e.tag.attr["length"];
									if("suffix" in e.tag.attr) info.metadata.suffix = e.tag.attr["suffix"];
									info.metadata.type = e.tag.attr["types"];
									info.metadata.id = e.tag.attr["ids"];
									foreach(t ; e.elements) {
										if(t.tag.name == "type") {
											auto end = "endianness" in t.tag.attr;
											info.metadata.types ~= Metadata.Type(t.tag.attr["name"].rename(), t.tag.attr["type"].rename(), t.tag.attr["id"].to!ubyte, end ? replace(*end, "-", "_") : "");
										}
									}
									break;
								case "metadatas":
									foreach(md ; e.elements) {
										if(md.tag.name == "type") {
											Metadata.Data meta;
											meta.name = md.tag.attr["name"].rename();
											meta.description = text(md);
											meta.type = md.tag.attr["type"].rename();
											meta.id = md.tag.attr["id"].to!ubyte;
											if("default" in md.tag.attr) meta.default_ = md.tag.attr["default"];
											if("required" in md.tag.attr) meta.required = md.tag.attr["required"].to!bool;
											foreach(f ; md.elements) {
												if(f.tag.name == "flag") {
													meta.flags ~= Metadata.Flag(f.tag.attr["name"].rename(), text(f), to!uint(f.tag.attr["bit"]));
													
												}
											}
											info.metadata.data ~= meta;
										}
									}
									break;
								default:
									break;
							}
						}
						break;
					default:
						break;
				}
			}
			data[info.game ~ info.version_.to!string] = info;
		}
	}

	// set latest protocols
	uint date(string str) {
		auto spl = str.split("/");
		return (to!uint(spl[0]) * 366 + to!uint(spl[1])) * 31 + to!uint(spl[2]);
	}
	uint[][string] latest;
	foreach(ref info ; data) {
		if(info.released.length) {
			immutable released = date(info.released);
			auto l = info.game in latest;
			if(l is null || released > (*l)[0]) latest[info.game] = [released, info.version_];
		}
	}
	foreach(game, v; latest) {
		data[game ~ to!string(v[1])].latest = true;
	}
	
	Generator.generateAll(Data("Automatically generated libraries for encoding and decoding Minecraft protocols", "MIT", exists("version.txt") ? strip(cast(string)read("version.txt")) : "0.0.0", data), args.canFind("--diff"));
	
}

@property string rename(string str) {
	return str.replace("-", "_");
}

@property string text(Element element) {
	auto ret = split(strip((){
				if(element.texts.length) {
					return element.texts[0].to!string;
				} else {
					try {
						return element.text;
					} catch(DecodeException) {
						return "";
					}
				}
			}()), "\n");
	foreach(ref str ; ret) str = decode(str.replaceAll(ctRegex!"[\r\t]", ""));
	return ret.join("\n");
}
