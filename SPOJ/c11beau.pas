const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        ca,cb,ma,mb,ans:int64;

procedure swap(var a,b:int64);
var     tm:longint;
begin
        tm:=a;a:=b;b:=tm;
end;

function min(a,b:int64):int64;
begin
        if a<b then exit(a) else exit(b);
end;

procedure process;
begin
        ans:=0;
        if ma=0 then ans:=min(mb,cb) else
        if mb=0 then ans:=min(ma,ca) else
        if ca=cb then ans:=ca*2 else
        begin
                if cb>ca then
                begin
                        swap(ca,cb);
                        swap(ma,mb);
                end;
                ans:=ma*(cb+1)+cb;
                ans:=min(ans,ca+cb);
        end;
end;

procedure main;
var     i,t:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for i:=1 to t do
        begin
                readln(gi,ca,cb,ma,mb);
                process;
                writeln(go,ans);
        end;
        close(gi);close(go);
end;

begin
        main;
end.
