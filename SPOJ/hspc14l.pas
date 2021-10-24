
bai sai
{
const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        s:string;
        ok,dd:boolean;
        n:longint;
        a,d:array[0..10] of longint;

procedure crea;
var     i:longint;
begin
        ok:=true;dd:=true;
        while s[1]=' ' do delete(s,1,1);
        while s[length(s)]=' ' do delete(s,length(s),1);
        if s[1]='-' then dd:=false;
        if dd=false then exit;
        n:=length(s);
        fillchar(d,sizeof(d),0);
        fillchar(a,sizeof(a),0);
        for i:=1 to n do a[i]:=ord(s[n-i+1])-48;
end;

procedure outp;
var     i:longint;
begin
        if dd=false then
        begin
                writeln(go,1);
                exit;
        end;
        if ok=false then
        begin
                writeln(go,0);
                exit;
        end;
        if a[n+1]<>0 then write(go,a[n+1]);
        for i:=n downto 1 do write(go,a[i]);
        writeln(go);
end;

procedure down(i:longint);
var     j:longint;
begin
        if i<=0 then exit;
        for j:=1 to 9 do
                if d[j]=0 then
                begin
                        a[i]:=j;
                        d[j]:=i;
                        down(i-1);
                        exit;
                end;
        ok:=false;
end;

procedure update(i:longint);
var     j:longint;
begin
        if i>9 then
        begin
                ok:=false;
                exit;
        end;
        if d[a[i]]=i then d[a[i]]:=0;
        for j:=a[i]+1 to 9 do
                if d[j]=0 then
                begin
                        a[i]:=j;
                        d[j]:=i;
                        down(i-1);
                        exit;
                end;
        update(i+1);
end;

procedure proc;
var     i:longint;
        tang:boolean;
begin
        tang:=false;
        for i:=n downto 2 do
                if d[a[i]]=0 then d[a[i]]:=i
                else
                begin
                        tang:=true;
                        update(i);
                end;
        if tang=false then update(1);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        repeat
                readln(gi,s);
                if s='' then break;
                crea;
                if dd then proc;
                outp;
        until false;
        close(gi);close(go);
end.
