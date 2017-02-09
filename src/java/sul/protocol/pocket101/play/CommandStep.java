/*
 * This file was automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generated from https://github.com/sel-project/sel-utils/blob/master/xml/protocol/pocket101.xml
 */
package sul.protocol.pocket101.play;

import java.nio.charset.StandardCharsets;

import sul.utils.*;

public class CommandStep extends Packet {

	public static final byte ID = (byte)78;

	public static final boolean CLIENTBOUND = false;
	public static final boolean SERVERBOUND = true;

	public String command;
	public String overload;
	public int unknown2;
	public int unknown3;
	public boolean isOutput;
	public long unknown5;
	public String input;
	public String output;

	public CommandStep() {}

	public CommandStep(String command, String overload, int unknown2, int unknown3, boolean isOutput, long unknown5, String input, String output) {
		this.command = command;
		this.overload = overload;
		this.unknown2 = unknown2;
		this.unknown3 = unknown3;
		this.isOutput = isOutput;
		this.unknown5 = unknown5;
		this.input = input;
		this.output = output;
	}

	@Override
	public int length() {
		return Buffer.varuintLength(command.getBytes(StandardCharsets.UTF_8).length) + command.getBytes(StandardCharsets.UTF_8).length + Buffer.varuintLength(overload.getBytes(StandardCharsets.UTF_8).length) + overload.getBytes(StandardCharsets.UTF_8).length + Buffer.varuintLength(unknown2) + Buffer.varuintLength(unknown3) + Buffer.varulongLength(unknown5) + Buffer.varuintLength(input.getBytes(StandardCharsets.UTF_8).length) + input.getBytes(StandardCharsets.UTF_8).length + Buffer.varuintLength(output.getBytes(StandardCharsets.UTF_8).length) + output.getBytes(StandardCharsets.UTF_8).length + 2;
	}

	@Override
	public byte[] encode() {
		this._buffer = new byte[this.length()];
		this.writeBigEndianByte(ID);
		byte[] y29tbwfuza=command.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)y29tbwfuza.length); this.writeBytes(y29tbwfuza);
		byte[] b3zlcmxvywq=overload.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)b3zlcmxvywq.length); this.writeBytes(b3zlcmxvywq);
		this.writeVaruint(unknown2);
		this.writeVaruint(unknown3);
		this.writeBool(isOutput);
		this.writeVarulong(unknown5);
		byte[] aw5wdxq=input.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)aw5wdxq.length); this.writeBytes(aw5wdxq);
		byte[] b3v0chv0=output.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)b3v0chv0.length); this.writeBytes(b3v0chv0);
		return this.getBuffer();
	}

	@Override
	public void decode(byte[] buffer) {
		this._buffer = buffer;
		readBigEndianByte();
		int bgvuy29tbwfuza=this.readVaruint(); command=new String(this.readBytes(bgvuy29tbwfuza), StandardCharsets.UTF_8);
		int bgvub3zlcmxvywq=this.readVaruint(); overload=new String(this.readBytes(bgvub3zlcmxvywq), StandardCharsets.UTF_8);
		unknown2=this.readVaruint();
		unknown3=this.readVaruint();
		isOutput=this.readBool();
		unknown5=this.readVarulong();
		int bgvuaw5wdxq=this.readVaruint(); input=new String(this.readBytes(bgvuaw5wdxq), StandardCharsets.UTF_8);
		int bgvub3v0chv0=this.readVaruint(); output=new String(this.readBytes(bgvub3v0chv0), StandardCharsets.UTF_8);
	}

	public static CommandStep fromBuffer(byte[] buffer) {
		CommandStep ret = new CommandStep();
		ret.decode(buffer);
		return ret;
	}

	@Override
	public String toString() {
		return "CommandStep(command: " + this.command + ", overload: " + this.overload + ", unknown2: " + this.unknown2 + ", unknown3: " + this.unknown3 + ", isOutput: " + this.isOutput + ", unknown5: " + this.unknown5 + ", input: " + this.input + ", output: " + this.output + ")";
	}

}