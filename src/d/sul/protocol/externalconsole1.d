module sul.protocol.externalconsole1;

import std.bitmanip : read, write;
import std.conv : to;
import std.uuid : UUID;
import std.system : Endian;
import std.typecons : Tuple, tuple;

import sul.types.var;

static struct Types {

}

static struct Packets {

	static struct Play {

		static struct Command {

			public enum ubyte packetId = 4;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public string command;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				ubyte[] Y29tbWFuZA=cast(ubyte[])command; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, Y29tbWFuZA.length.to!ushort, buffer.length-ushort.sizeof); buffer~=Y29tbWFuZA;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				ubyte[] Y29tbWFuZA; if(buffer.length>=ushort.sizeof){ Y29tbWFuZA.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=Y29tbWFuZA.length){ Y29tbWFuZA=buffer[0..Y29tbWFuZA.length]; buffer=buffer[Y29tbWFuZA.length..$]; }; command=cast(string)Y29tbWFuZA;
				return this;
			}

		}

		static struct ConsoleMessage {

			public enum ubyte packetId = 3;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string node;
			public ulong timestamp;
			public string logger;
			public string message;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				ubyte[] bm9kZQ=cast(ubyte[])node; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, bm9kZQ.length.to!ushort, buffer.length-ushort.sizeof); buffer~=bm9kZQ;
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, timestamp, buffer.length-ulong.sizeof);
				ubyte[] bG9nZ2Vy=cast(ubyte[])logger; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, bG9nZ2Vy.length.to!ushort, buffer.length-ushort.sizeof); buffer~=bG9nZ2Vy;
				ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, bWVzc2FnZQ.length.to!ushort, buffer.length-ushort.sizeof); buffer~=bWVzc2FnZQ;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				ubyte[] bm9kZQ; if(buffer.length>=ushort.sizeof){ bm9kZQ.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=bm9kZQ.length){ bm9kZQ=buffer[0..bm9kZQ.length]; buffer=buffer[bm9kZQ.length..$]; }; node=cast(string)bm9kZQ;
				if(buffer.length>=ulong.sizeof){ timestamp=read!(ulong, Endian.bigEndian)(buffer); }
				ubyte[] bG9nZ2Vy; if(buffer.length>=ushort.sizeof){ bG9nZ2Vy.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=bG9nZ2Vy.length){ bG9nZ2Vy=buffer[0..bG9nZ2Vy.length]; buffer=buffer[bG9nZ2Vy.length..$]; }; logger=cast(string)bG9nZ2Vy;
				ubyte[] bWVzc2FnZQ; if(buffer.length>=ushort.sizeof){ bWVzc2FnZQ.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
				return this;
			}

		}

		static struct PermissionDenied {

			public enum ubyte packetId = 5;

			public enum bool clientbound = true;
			public enum bool serverbound = false;


			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				return this;
			}

		}

	}

	static struct Login {

		static struct AuthCredentials {

			public enum ubyte packetId = 0;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte protocol;
			public string hashAlgorithm;
			public ubyte[16] payload;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, protocol, buffer.length-ubyte.sizeof);
				ubyte[] aGFzaEFsZ29yaXRo=cast(ubyte[])hashAlgorithm; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, aGFzaEFsZ29yaXRo.length.to!ushort, buffer.length-ushort.sizeof); buffer~=aGFzaEFsZ29yaXRo;
				 buffer~=payload;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ protocol=read!(ubyte, Endian.bigEndian)(buffer); }
				ubyte[] aGFzaEFsZ29yaXRo; if(buffer.length>=ushort.sizeof){ aGFzaEFsZ29yaXRo.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=aGFzaEFsZ29yaXRo.length){ aGFzaEFsZ29yaXRo=buffer[0..aGFzaEFsZ29yaXRo.length]; buffer=buffer[aGFzaEFsZ29yaXRo.length..$]; }; hashAlgorithm=cast(string)aGFzaEFsZ29yaXRo;
				if(buffer.length>=payload.length){ payload=buffer[0..payload.length]; buffer=buffer[payload.length..$]; }
				return this;
			}

		}

		static struct Welcome {

			public enum ubyte packetId = 2;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte status;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, status, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ status=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

			static struct WrongHash {

				public enum ubyte status = 1;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, status, buffer.length-ubyte.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct Accepted {

				public enum ubyte status = 0;
				public bool remoteCommands;
				public string software;
				public ubyte[3] versions;
				public uint[] pocketProtocols;
				public uint[] minecraftProtocols;
				public string[] connectedNodes;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, status, buffer.length-ubyte.sizeof);
					buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, remoteCommands, buffer.length-bool.sizeof);
					ubyte[] c29mdHdhcmU=cast(ubyte[])software; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, c29mdHdhcmU.length.to!ushort, buffer.length-ushort.sizeof); buffer~=c29mdHdhcmU;
					 buffer~=versions;
					buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, pocketProtocols.length.to!ushort, buffer.length-ushort.sizeof);foreach(cG9ja2V0UHJvdG9j;pocketProtocols){ buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, cG9ja2V0UHJvdG9j, buffer.length-uint.sizeof); }
					buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, minecraftProtocols.length.to!ushort, buffer.length-ushort.sizeof);foreach(bWluZWNyYWZ0UHJv;minecraftProtocols){ buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, bWluZWNyYWZ0UHJv, buffer.length-uint.sizeof); }
					buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, connectedNodes.length.to!ushort, buffer.length-ushort.sizeof);foreach(Y29ubmVjdGVkTm9k;connectedNodes){ ubyte[] WTI5dWJtVmpkR1Zr=cast(ubyte[])Y29ubmVjdGVkTm9k; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, WTI5dWJtVmpkR1Zr.length.to!ushort, buffer.length-ushort.sizeof); buffer~=WTI5dWJtVmpkR1Zr; }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					if(buffer.length>=bool.sizeof){ remoteCommands=read!(bool, Endian.bigEndian)(buffer); }
					ubyte[] c29mdHdhcmU; if(buffer.length>=ushort.sizeof){ c29mdHdhcmU.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=c29mdHdhcmU.length){ c29mdHdhcmU=buffer[0..c29mdHdhcmU.length]; buffer=buffer[c29mdHdhcmU.length..$]; }; software=cast(string)c29mdHdhcmU;
					if(buffer.length>=versions.length){ versions=buffer[0..versions.length]; buffer=buffer[versions.length..$]; }
					if(buffer.length>=ushort.sizeof){ pocketProtocols.length=read!(ushort, Endian.bigEndian)(buffer); }foreach(ref cG9ja2V0UHJvdG9j;pocketProtocols){ if(buffer.length>=uint.sizeof){ cG9ja2V0UHJvdG9j=read!(uint, Endian.bigEndian)(buffer); }}
					if(buffer.length>=ushort.sizeof){ minecraftProtocols.length=read!(ushort, Endian.bigEndian)(buffer); }foreach(ref bWluZWNyYWZ0UHJv;minecraftProtocols){ if(buffer.length>=uint.sizeof){ bWluZWNyYWZ0UHJv=read!(uint, Endian.bigEndian)(buffer); }}
					if(buffer.length>=ushort.sizeof){ connectedNodes.length=read!(ushort, Endian.bigEndian)(buffer); }foreach(ref Y29ubmVjdGVkTm9k;connectedNodes){ ubyte[] WTI5dWJtVmpkR1Zr; if(buffer.length>=ushort.sizeof){ WTI5dWJtVmpkR1Zr.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=WTI5dWJtVmpkR1Zr.length){ WTI5dWJtVmpkR1Zr=buffer[0..WTI5dWJtVmpkR1Zr.length]; buffer=buffer[WTI5dWJtVmpkR1Zr.length..$]; }; Y29ubmVjdGVkTm9k=cast(string)WTI5dWJtVmpkR1Zr;}
					return this;
				}

			}

			static struct TimedOut {

				public enum ubyte status = 2;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, status, buffer.length-ubyte.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					return this;
				}

			}

		}

		static struct Auth {

			public enum ubyte packetId = 1;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte[] hash;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, hash.length.to!ushort, buffer.length-ushort.sizeof); buffer~=hash;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ushort.sizeof){ hash.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=hash.length){ hash=buffer[0..hash.length]; buffer=buffer[hash.length..$]; }
				return this;
			}

		}

	}

	static struct Status {

		static struct UpdateNodes {

			public enum ubyte packetId = 1;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte action;
			public string node;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, action, buffer.length-ubyte.sizeof);
				ubyte[] bm9kZQ=cast(ubyte[])node; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, bm9kZQ.length.to!ushort, buffer.length-ushort.sizeof); buffer~=bm9kZQ;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ action=read!(ubyte, Endian.bigEndian)(buffer); }
				ubyte[] bm9kZQ; if(buffer.length>=ushort.sizeof){ bm9kZQ.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=bm9kZQ.length){ bm9kZQ=buffer[0..bm9kZQ.length]; buffer=buffer[bm9kZQ.length..$]; }; node=cast(string)bm9kZQ;
				return this;
			}

		}

		static struct KeepAlive {

			public enum ubyte packetId = 0;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public uint count;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, count, buffer.length-uint.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=uint.sizeof){ count=read!(uint, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct UpdateStats {

			public enum ubyte packetId = 2;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string displayName;
			public uint onlinePlayers;
			public uint maxPlayers;
			public uint uptime;
			public uint upload;
			public uint download;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				ubyte[] ZGlzcGxheU5hbWU=cast(ubyte[])displayName; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, ZGlzcGxheU5hbWU.length.to!ushort, buffer.length-ushort.sizeof); buffer~=ZGlzcGxheU5hbWU;
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, onlinePlayers, buffer.length-uint.sizeof);
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, maxPlayers, buffer.length-uint.sizeof);
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, uptime, buffer.length-uint.sizeof);
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, upload, buffer.length-uint.sizeof);
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, download, buffer.length-uint.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				ubyte[] ZGlzcGxheU5hbWU; if(buffer.length>=ushort.sizeof){ ZGlzcGxheU5hbWU.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=ZGlzcGxheU5hbWU.length){ ZGlzcGxheU5hbWU=buffer[0..ZGlzcGxheU5hbWU.length]; buffer=buffer[ZGlzcGxheU5hbWU.length..$]; }; displayName=cast(string)ZGlzcGxheU5hbWU;
				if(buffer.length>=uint.sizeof){ onlinePlayers=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=uint.sizeof){ maxPlayers=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=uint.sizeof){ uptime=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=uint.sizeof){ upload=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=uint.sizeof){ download=read!(uint, Endian.bigEndian)(buffer); }
				return this;
			}

		}

	}

}
