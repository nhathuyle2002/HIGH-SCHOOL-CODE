const   ginp='minnum.inp';
        gout='minnum.out';

var     gi,go:text;
        d:array[0..9] of boolean;
        gtm:longint;
        s:string;

procedure input;
var     i,n,tm:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        fillchar(d,sizeof(d),true);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,tm);
                d[tm]:=false;
        end;
        i:=0;
        while d[i]=false do inc(i);
        gtm:=i;
        readln(gi);
        read(gi,s);
        while s[1]=' ' do delete(s,1,1);
        while s[length(s)]=' ' do delete(s,length(s),1);
end;

function doi(x:char):longint;
begin
        doi:=ord(x)-48;
end;

function dio(x:longint):char;
begin
        dio:=chr(x+48);
end;

function find(x:longint):longint;
var     i:longint;
begin
        for i:=x+1 to 9 do
                if d[i] then exit(i);
        exit(-1);
end;

procedure process;
var     i,tm,j:longint;
begin
        s:='0'+s;
        for i:=2 to length(s) do
                if (d[doi(s[i])]=false) then
                begin
                        tm:=find(doi(s[i]));
                        if tm<>-1 then
                        begin
                                s[i]:=dio(tm);
                                j:=i;
                        end
                        else
                        for j:=i-1 downto 1 do
                        begin
                                tm:=find(doi(s[j]));
                                if tm<>-1 then
                                begin
                                        s[j]:=dio(tm);
                                        break;
                                end;
                        end;
                        for tm:=j+1 to length(s) do s[tm]:=dio(gtm);
                        exit;
                end;

        for i:=length(s) downto 1 do
        begin
                tm:=find(doi(s[i]));
                if tm<>-1 then
                begin
                        s[i]:=dio(tm);
                        break;
                end;
        end;
        for j:=i+1 to length(s) do s[j]:=dio(gtm);
end;

procedure output;
begin
        while s[1]='0' do delete(s,1,1);
        write(go,s);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.











