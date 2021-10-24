type    save=record n,s,k:longint; end;

const   ginp='ss.inp';
        gout='ss.out';

var     maxe:longint;
        f,g:array[0..10010] of save;

procedure process;
var     i,j:longint;
begin
        readln(maxe);
        for i:=1 to maxe do
                for j:=trunc(sqrt(i)) downto 1 do
                        if i mod j=0 then
                        begin
                                g[i].n:=j+i div j;
                                g[i].s:=j;
                                g[i].k:=1;
                                break;
                        end;
        for i:=1 to maxe do
        begin
                f[i]:=g[i];
                for j:=i-1 downto (i div 2+i mod 2) do
                        if f[j].n+f[i-j].n<f[i].n then
                        begin
                                f[i].n:=f[j].n+f[i-j].n;
                                f[i].s:=f[j].s+f[i-j].s;
                                f[i].k:=f[j].k+f[i-j].k;
                        end else
                        if f[j].n+f[i-j].n=f[i].n then
                        begin
                                if f[j].s+f[i-j].s<f[i].s then
                                begin
                                        f[i].s:=f[j].s+f[i-j].s;
                                        f[i].k:=f[j].k+f[i-j].k;
                                end else
                                if f[j].s+f[i-j].s=f[i].s then
                                        if f[j].k+f[i-j].k<f[i].k then f[i].k:=f[j].k+f[i-j].k;
                        end;
        end;
        write(f[maxe].n,' ',f[maxe].s,' ',f[maxe].k);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
