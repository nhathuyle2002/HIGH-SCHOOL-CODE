const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        mu2:array[0..31] of int64;

function dn(x:char):char;
begin
        if x='U' then exit('D') else exit('U');
end;

function find(sl:longint;vt:int64):char;
begin
        if vt=mu2[sl-1] then find:='D' else
        if vt<mu2[sl-1] then find:=find(sl-1,vt)
        else find:=dn(find(sl-1,mu2[sl]-vt));
end;

procedure main;
var     i,sl:longint;
        vt:int64;
begin
        mu2[0]:=1;
        for i:=1 to 31 do mu2[i]:=mu2[i-1]*2;
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        repeat
                readln(gi,sl,vt);
                if (sl=0) and (vt=0) then break;
                writeln(go,find(sl,mu2[sl]-vt));
        until false;
        close(gi);close(go);
end;

begin
        main;
end.