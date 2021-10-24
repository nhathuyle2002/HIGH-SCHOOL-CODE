const   ginp='hangpics.inp';
        gout='hangpics.out';

var     gi,go:text;
        a,b:array[1..3] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        for i:=1 to 3 do readln(gi,a[i],b[i]);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function process:boolean;
begin
        if (a[2]+a[3]<=a[1]) and (max(b[2],b[3])<=b[1]) then exit(true);
        if (a[2]+b[3]<=a[1]) and (max(b[2],a[3])<=b[1]) then exit(true);
        if (b[2]+b[3]<=b[1]) and (max(a[2],a[3])<=a[1]) then exit(true);
        if (b[2]+a[3]<=b[1]) and (max(a[2],b[3])<=a[1]) then exit(true);
        if (b[2]+a[3]<=a[1]) and (max(a[2],b[3])<=b[1]) then exit(true);
        if (b[2]+b[3]<=a[1]) and (max(a[2],a[3])<=a[1]) then exit(true);
        if (a[2]+b[3]<=b[1]) and (max(b[2],a[3])<=a[1]) then exit(true);
        if (a[2]+a[3]<=b[1]) and (max(b[2],b[3])<=a[1]) then exit(true);
        exit(false);
end;

procedure output;
begin
        if process then write(go,'YES') else write(go,'NO');
        close(gi);close(go);
end;

begin
        input;
        output;
end.

